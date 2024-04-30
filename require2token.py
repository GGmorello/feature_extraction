from tqdm import tqdm
import os
from pathlib import Path

from antlr4 import *
from solidity_parser.solidity_antlr4.SolidityLexer import SolidityLexer
from solidity_parser.solidity_antlr4.SolidityParser import SolidityParser
from solidity_parser.solidity_antlr4.SolidityVisitor import SolidityVisitor

class RequireVisitor(SolidityVisitor):
    def __init__(self):
        self.locations = []
        self.current_contract = None
        self.current_function = None
    
    def visitChildren(self, node):
        if 'require' not in node.getText():
            return
        return super().visitChildren(node)
        
    def visitFunctionDefinition(self, ctx:SolidityParser.FunctionDefinitionContext):
        if 'require' not in ctx.getText():
            return
        self.current_function = (ctx.start.line, ctx.stop.line)
        return super().visitFunctionDefinition(ctx)
    
    def visitModifierDefinition(self, ctx: SolidityParser.ModifierDefinitionContext):
        if 'require' not in ctx.getText():
            return
        self.current_function = (ctx.start.line, ctx.stop.line)

        return super().visitModifierDefinition(ctx)
    
    def visitContractDefinition(self, ctx: SolidityParser.ContractDefinitionContext):
        if 'require' not in ctx.getText():
            return
        self.current_contract = (ctx.start.line, ctx.stop.line)
        return super().visitContractDefinition(ctx)

    def visitExpressionStatement(self, ctx:SolidityParser.ExpressionStatementContext):
        text = ctx.getText()
        if 'require' in text:
            children = [child for child in ctx.getChild(0).getChild(2).getChild(0).getChildren() if child.getText() != 'require']
            if len(children) == 3:
                pred, _, comment = children
            if len(children) == 1:
                pred = children[0]
            
            start = ctx.start
            stop = ctx.stop
            self.locations.append({
                'require': {
                    'start_line': start.line,
                    'start_column': start.column,
                    'end_line': stop.line,
                    'end_column': stop.column,
                    'text': text,
                    'predicate': pred.getText(),
                    'comment': comment.getText() if len(children) == 3 else None
                },
                'contract': {
                    'start_line': self.current_contract[0],
                    'end_line': self.current_contract[1]
                },
                'function': {
                    'start_line': self.current_function[0],
                    'end_line': self.current_function[1]
                }
            })

def parse(text):
    if not text:
        return None
    input_stream = InputStream(text)
    lexer = SolidityLexer(input_stream)
    token_stream = CommonTokenStream(lexer)
    parser = SolidityParser(token_stream)
    visitor = RequireVisitor()
    tree = parser.sourceUnit()

    visitor.visit(tree)    


    return visitor.locations

def change_require_statements(file_path, result_folder, token):
    Path(result_folder).mkdir(parents=True, exist_ok=True)

    with open(file_path, 'r', encoding="utf-8") as f:
        text = f.read()
        locations = parse(text)

    for i, location in enumerate(locations):
        # for every location replace the text at the given location with the token and write the new file to the result folder
        # start_line, start_column, end_line, end_column, _, _, _ = location
        start_line = location['require']['start_line']
        start_column = location['require']['start_column']
        end_line = location['require']['end_line']
        end_column = location['require']['end_column']

        lines = text.split('\n')
        if start_line == end_line:
            lines[start_line - 1] = lines[start_line - 1][:start_column] + token + lines[start_line - 1][end_column + 1:]
        else:
            lines[start_line - 1] = lines[start_line - 1][:start_column] + token
            lines[end_line - 1] = lines[end_line - 1][end_column + 1:]
            del lines[start_line:end_line-1]

        with open(os.path.join(result_folder, file_path.split('/')[-1][:-4] + f'_{i}.sol' ), 'w', encoding="utf-8", ) as f:
            f.write('\n'.join(lines))
        with open(os.path.join(result_folder, file_path.split('/')[-1][:-4] + f'_{i}_contract.sol' ), 'w', encoding="utf-8", ) as f:
            f.write('\n'.join(lines[location['contract']['start_line']-1:location['contract']['end_line']]))
        with open(os.path.join(result_folder, file_path.split('/')[-1][:-4] + f'_{i}_function.sol' ), 'w', encoding="utf-8", ) as f:
            f.write('\n'.join(lines[location['function']['start_line']-1:location['function']['end_line']]))
    return

def change_require_statements_string(text, token):
    locations = parse(text)
    result = []
    for i, location in enumerate(locations):
        start_line, start_column, end_line, end_column, require, predicate, comment = location
        lines = text.split('\n')
        if start_line == end_line:
            lines[start_line - 1] = lines[start_line - 1][:start_column] + token + lines[start_line - 1][end_column + 1:]
        else:
            lines[start_line - 1] = lines[start_line - 1][:start_column] + token
            lines[end_line - 1] = lines[end_line - 1][end_column + 1:]
            del lines[start_line:end_line-1]

        result.append(('\n'.join(lines) + "\n", require[8:], predicate, comment))
    return result


def main():
    for f in tqdm(os.listdir("/Users/gabrielemorello/Code/FLAMES/feature_extraction/sources")):
        if f.endswith(".sol"):
            change_require_statements(f"/Users/gabrielemorello/Code/FLAMES/feature_extraction/sources/{f}", f"./results/{f}/", "require(<FILL_ME>)")

if __name__ == "__main__":
    main()


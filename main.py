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

    def visitExpressionStatement(self, ctx:SolidityParser.ExpressionStatementContext):
        if 'require' in  ctx.getText():
            start = ctx.start
            stop = ctx.stop
            self.locations.append((start.line, start.column, stop.line, stop.column))

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
        # for every location replace the text at the given location with the token and write the new file to the result folderù
        start_line, start_column, end_line, end_column = location
        lines = text.split('\n')
        if start_line == end_line:
            lines[start_line - 1] = lines[start_line - 1][:start_column] + token + lines[start_line - 1][end_column + 1:]
        else:
            lines[start_line - 1] = lines[start_line - 1][:start_column] + token
            lines[end_line - 1] = lines[end_line - 1][end_column + 1:]
            del lines[start_line:end_line-1]

        with open(os.path.join(result_folder, file_path.split('/')[-1][:-4] + f'_{i}.sol' ), 'w', encoding="utf-8", ) as f:
            f.write('\n'.join(lines))
    return


def main():
    for f in tqdm(os.listdir("/Users/gabrielemorello/Code/FLAMES/feature_extraction/sources")):
        if f.endswith(".sol"):
            change_require_statements(f"/Users/gabrielemorello/Code/FLAMES/feature_extraction/sources/{f}", f"./results/{f}/", "<REQUIRE>")

if __name__ == "__main__":
    main()
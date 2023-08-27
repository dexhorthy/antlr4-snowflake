import sys

from antlr4 import CommonTokenStream
from antlr4 import StdinStream

from SnowflakeLexer import SnowflakeLexer
from SnowflakeParser import SnowflakeParser


def main(argv):
    input = StdinStream()
    lexer = SnowflakeLexer(input)
    stream = CommonTokenStream(lexer)
    parser = SnowflakeParser(stream)
    tree = parser.query_statement()
    print(janky_pretty_print_antlr_tree(tree.toStringTree(recog=parser)))


def janky_pretty_print_antlr_tree(tree: str) -> str:
    """
    Turn a one-liner antlr string into a more lisp-y looking structure.
    This is rough but an incremental improvement on trying to read the one-liner.

    Either this really doesn't exist, or I suck at google.
    """
    words = tree.split()
    lines = []
    indent = 0
    for word in words:
        closes = word.count(')')
        opens = word.count('(')
        prefix = ''
        if opens:
            indent += opens
            prefix = '\n' + (indent * 2 * ' ')
        elif closes:
            indent -= closes
            prefix = ' '
        elif word in {',', '.'}:
            pass
        else:
            prefix = ' '

        lines.append(prefix + word)

    return ''.join(lines)


if __name__ == '__main__':
    main(sys.argv)

import sys
import antlr3
import antlr3.tree
from ahLexer import ahLexer
from ahParser import ahParser

char_stream = antlr3.ANTLRInputStream(sys.stdin)
lexer = ahLexer(char_stream)
tokens = antlr3.CommonTokenStream(lexer)
parser = ahParser(tokens)

r = parser.prog()

print(r.value)

# this is the root of the AST
#root = r.tree

#nodes = antlr3.tree.CommonTreeNodeStream(root)
#nodes.setTokenStream(tokens)

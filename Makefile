
.PHONY: wget_grammars
wget_grammars:
	wget https://raw.githubusercontent.com/antlr/grammars-v4/master/sql/snowflake/SnowflakeLexer.g4
	wget https://raw.githubusercontent.com/antlr/grammars-v4/master/sql/snowflake/SnowflakeParser.g4

.PHONY: compile
compile:
	antlr4 -Dlanguage=Python3 SnowflakeLexer.g4
	antlr4 -Dlanguage=Python3 SnowflakeParser.g4

.PHONY: parse-small
parse-small:
	cat query_small.sql | python print_query_tree.py

.PHONY: parse-big
parse-big:
	cat query_big.sql | python print_query_tree.py

.PHONY: clean
clean:
	rm *.g4 *.interp *.tokens *Lexer.py *Parser.py *Listener.py

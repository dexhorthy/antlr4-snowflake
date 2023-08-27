# Antlr4 Snowflake Python

This repo is a work in progress, looking to explore how some tools fit together,
and do some hello-world-y stuff w/ Antlr4.


### Resources

#### `pip` Dependencies

```bash
pip install -r requirements.txt
```

#### Fetch snowflake parser grammar

```bash
wget https://raw.githubusercontent.com/antlr/grammars-v4/master/sql/snowflake/SnowflakeLexer.g4
wget https://raw.githubusercontent.com/antlr/grammars-v4/master/sql/snowflake/SnowflakeParser.g4
```


### Codegen and Parsing

Use antlr4 from the `antlr4-tools` pip pacakge to compile the grammars to python code:

```bash
antlr4 -Dlanguage=Python3 SnowflakeLexer.g4 
antlr4 -Dlanguage=Python3 SnowflakeParser.g4
```

Next, we can parse the small example query, shown below from `query_small.sql`:

```sql
SELECT COUNT(*) as weekly_active_users
FROM users
WHERE DATEDIFF('day', last_active, CURRENT_TIMESTAMP) < 7
```

```bash
cat query_small.sql | python print_query_tree.py
```

This will print the parsed tree for the query

```
  (query_statement
    (select_statement
      (select_clause SELECT
        (select_list_no_top
          (select_list
            (select_list_elem
              (expression_elem
                (expr
                  (function_call
                    (aggregate_function
                      (id_
                        (builtin_function COUNT))
                      ( * ))))
                (as_alias AS
                  (alias
                    (id_ weekly_active_users))))))))
      (select_optional_clauses
        (from_clause FROM
          (table_sources
            (table_source
              (table_source_item_joined
                (object_ref
                  (object_name
                    (id_ active_users)))))))
        (where_clause WHERE
          (search_condition
            (predicate
              (expr
                (ternary_builtin_function DATEDIFF)
                (
                  (expr
                    (primitive_expression
                      (literal 'day'))),
                  (expr
                    (primitive_expression
                      (id_ last_active))),
                  (expr
                    (primitive_expression
                      (id_
                        (builtin_function CURRENT_TIMESTAMP)))) ))
              (comparison_operator <)
              (expr
                (primitive_expression
                  (literal 7)))))))))
```

### A Bigger Query

Try it yourself with the larger, more complex query.

```bash
cat query_big.sql | python print_query_tree.py
```


### Acknowledgements / References

- [Antlr4 Website](https://www.antlr.org/) - @ 
- [Python 3 Examples from Antlr4 Book](https://github.com/jszheng/py3antlr4book) - @jszheng
- [Antlr4-Python](https://github.com/AlanHohn/antlr4-python#getting-started) - @AlanHohn
- [Snowflake Grammar for Antlr4](https://github.com/antlr/grammars-v4/tree/master/sql/snowflake)

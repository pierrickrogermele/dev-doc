JSON
====

Reindent JSON within VIM:
```vim
:%!python -m json.tool
```

## Check JSON file

```bash
python -m json.tool <myfile.json
```

## Lists / dictionaries

```json
{"success":false,"error":"token_required"}
```

## Array

```json
["val1", "val2"]
```

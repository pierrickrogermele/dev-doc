<!-- vimvars: b:markdown_embedded_syntax={'yaml':''} -->
# YAML file

 * [YAML](https://en.wikipedia.org/wiki/YAML).
 * [Official YAML website](http://yaml.org/).
 * [YAML syntax validator](http://www.yamllint.com/).

## shyaml

A Python command line tool to access YAML files.
Installing using pip:
```sh
pip install shyaml
```

Installing with yay under ArchLinux:
```sh
yay -S shyaml
```

Reading a field value:
```sh
shyaml get-value field1.field2.field3 <my.yml
```

## Alignment

Attention at putting rightmost dashes without spaces before.
Use spaces to align and not tabs.
Align strictly the fields that are on a same level.
```yaml
--- 
- 
  hosts: galaxyservers
  roles: 
    - 
      role: ansible-galaxy
      sudo: true
  vars: 
    galaxy_changeset_id: tip
    galaxy_config_dir: /opt/galaxy/config
    galaxy_mutable_config_dir: /var/opt/galaxy/config
    galaxy_mutable_data_dir: /var/opt/galaxy/data
    galaxy_repo: "https://bitbucket.org/galaxy/galaxy-central/"
    galaxy_server_dir: /opt/galaxy/server
```

## Conversion from JSON

Converting a file from JSON to YAML:
```bash
python -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)' < file.json > file.yaml
```

## Multiline text

In a multiline text, if you want to escape colon char (`:`):
```yaml
---
-
  field:
    - some text
    - some other text
    - |-
        "some text with a colon : inside it"
```
Quoting is not enough.

## Null value

Write a null value in YAML:
```yaml
---
myfield1: ~
myfield2:
myfield3: null
myfield3: Null
myfield3: NULL
```

## Multiple sections

The `---` line indicates the start of a new data set. Thus you can store multiple YAML "files" inside a single YAML file:
```yaml
---
field1: value1
field2: value2
---
fieldOfAnotherDataset: someValue
```

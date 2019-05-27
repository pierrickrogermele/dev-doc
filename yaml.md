YAML file
=========

 * [YAML](https://en.wikipedia.org/wiki/YAML).
 * [Official YAML website](http://yaml.org/).
 * [YAML syntax validator](http://www.yamllint.com/).

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

Converting a file from JSON to YAML:
```bash
python -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)' < file.json > file.yaml
```

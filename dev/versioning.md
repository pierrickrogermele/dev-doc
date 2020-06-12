# Versioning

## Cloud

 * [Codebase](http://www.codebasehq.com/packages). Payant.
 * [Googlecode](http://code.google.com). Pas de possibilité de repos privé.
 * [Unfuddle](https://unfuddle.com). Payant.

### GitHub

 * [Permission levels for an organization](https://help.github.com/articles/permission-levels-for-an-organization/).
 * [What happens to forks when a repository is deleted or changes visibility?](https://help.github.com/articles/what-happens-to-forks-when-a-repository-is-deleted-or-changes-visibility/).

 * [GitHub markup](https://github.com/github/markup).
 
 * [GitHub pages](https://pages.github.com): website for an account (personal or organization), or for a project.
 * [About GitHub Wikis](https://help.github.com/articles/about-github-wikis/): wiki page for one repository.
 * [Mastering Wikis](https://guides.github.com/features/wikis/).
 * [How To Use GitHub Wikis For Collaborative Documentation](https://nerds.inn.org/2014/05/19/applying-git-to-github-wikis/).

## Mercurial

### Log history

First add the following lines inside `$HOME/.hgrc`:
```
[extensions]
graphlog =
```
Then call the command glog:
```bash
hg glog
```

## Bazaar

To clone a git repository
```bash
bzr branch git://git.gnome.org/gnome-specimen
```

Getting stored identity:
```bash
bzr whoami
```

Setting identity:
```bash
bzr whoami "Pierrick Roger Mele <pierrick.rogermele@cea.fr>"
```

Init a shared repository:
```bash
bzr init-repo myrepos
```

Init a repository tree:
```bash
bzr init myrepos/trunk
```

Bazaar doesn't support submodules. However Bazaar has been working on "nested trees" concept. It's still under development.

## Subversion

Get help:
```bash
svn help some.command
```
	
Get source:
```bash
svn ... file:///var/svn/newrepos/some/project ...
svn ... svn+ssh://pierrick@teddy/svn/pierrick/newproject ...
```
	
Username:
```bash
svn ... --username <login> https://...
```
	
Create new repository:
```bash
svnadmin create /var/svn/newrepos
```
	
Import whole tree:
```bash
svn import mytree file:///var/svn/newrepos/some/project -m "Initial import"
svn import mytree svn+ssh://pierrick@teddy/svn/pierrick/newproject -m "Initial import"
```
	
List:
```bash
svn list file:///var/svn/newrepos/some/project
svn list svn+ssh://pierrick@teddy/svn/pierrick
```
	
Check out:
```bash
svn checkout http://svn.collab.net/repos/svn/trunk
svn checkout http://svn.collab.net/repos/svn/trunk subv
```
	
Update:
```bash
svn udpate
```
	
Add:
```bash
svn add <file>
```
	
Remove:
```bash
svn delete <file>
```
	
Copy:
```bash
svn copy <file1> <file2>
```
	
Move:
```bash
svn move <file1> <file2>
```
	
Mkdir (short for mkdir + svn add):
```bash
svn mkdir <dir>
```
	
See changes:
```bash
svn status
```
	
See diff:
```bash
svn diff
```
	
Ignoring files & directories:
```bash
svn propset svn:ignore <dirname> .
```
	
Editing ignore file:
```bash
svn propedit svn:ignore .
```
	
Undo changes:
```bash
svn revert <file>
```
Works also to cancel file addition or deletion.
	
Commit:
```bash
svn commit -m "blabla"
```
	
Resolve conflict:
```bash
svn resolve --accept theirs-full <myfile>
```
Accept action: postpone, base, mine-full, theirs-full, edit, and launch.
```bash
svn resolve --accept working <myfile> # when solving Tree Conflicts (two persons added the same file, or a file was update by one person and deleted by another).
```
	
External
Allows to make reference from a directory to another svn repository
```bash
svn propget svn:externals calc
```

Exporting a clean tree (without SVN binding):
```bash
svn export ...
```
	
### SVN Server

MacOS-X:
```bash
launchctl
load org.tigris.subversion.svnserve
start org.tigris.subversion.svnserve
```
<ctrl-D> to get out of launchctl

## GitHub

 * [Closing Issues via Pull Requests](https://github.com/blog/1506-closing-issues-via-pull-requests).

Use GitHub API to get size and other metadata about a repos:
```
https://api.github.com/repos/pkrog/biodb-cache
```
Size is expressed in KB.

## GitLab

 * [How To Set Up Continuous Integration Pipelines with GitLab CI on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-continuous-integration-pipelines-with-gitlab-ci-on-ubuntu-16-04).

GitLab CI:
 * A runner must be attached to a project. For that jobs must be tagged with the same tag as the runner inside the YAML file.
 * Check first the tags of the runners inside Project / Settings / CI/CD page.
 * Then edit your `.gitlab-ci.yml` file and inside each job section, add a `tags` section. Example:
```yaml
install_dependencies:
  stage: build
  script:
    - npm install
  tags:
    - bash

test_with_lab:
  stage: test
  script: npm test
  tags:
    - bash
```

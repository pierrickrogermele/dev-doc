# Git

 * [Pro Git book](http://git-scm.com/book/en/v2) by Scott Chacon and Ben Straub.
 * [Reference Manual](https://git-scm.com/docs).
 * [How to handle big repositories with git](http://blogs.atlassian.com/2014/05/handle-big-repositories-git/).
 * [Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow), branch naming conventions.
 * [A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/).

## archive

Create archive (zip) of sources.

```bash
git archive --prefix=myrepos-v1.0.1/ -o myrepos-1.0.1.tar.gz v1.0.1
```

## branch

List local branches:
```bash
git branch
git branch -vv # Prints more information, like tracked remote branche.
```

List remote branches:
```bash
git branch -r
```

List local branches & remote-tracking branches:
```bash
git branch -a
```

Create a branch (starting at HEAD):
```bash
git branch my_branch
```

Create a branch starting at a specific commit:
```bash
git branch my_branch my_commit_id
```

Deleting a branch locally and remotely:
```bash
git branch -d my_branch      # Delete locally
git push -d origin my_branch # Delete remotely
git push origin :my_branch   # Delete branch my_branch on remote
```

Make a local branch track a remote branch:
```bash
git branch -u myremote/mybranch # Apply on current local branch.
git branch -u myremote/mybranch mylocalbranch
```

## checkout

Get back a previously deleted file:
```bash
git checkout some_commit my/file/name.txt
```

Putting current modifications into a new branch:
```bash
git checkout -b my_new_branch
```

Putting current modifications into an existing branch:
```bash
git stash
git checkout other_branch
git stash pop
```

## cherry-pick

Apply an existing commit to the current branch:
```bash
git cherry-pick mycommit
```

## clean

Remove untracked files.

Remove all untracked files:
```bash
git clean -f
```

Dry run:
```bash
git clean -n
```

## clone

Clone a remote repository:
```bash
git clone git@github.com:pkrog/biodb
```

Clone a local repository:
```bash
git clone /path/to/repository
```

Clone from a machine using ssh:
```bash
git clone ssh://yourhost/~you/repository
```

Set a custom name for the cloned repository:
```bash
git clone /path/to/repository my_repos_name
```

Switch to a specific branch after cloning:
```bash
git clone -b mybranch https://my.server/myrepos
```

Clone only one specific branch:
```bash
git clone -b mybranch --single-branch https://my.server/myrepos
```

Retrieve also all submodules when cloning:
```bash
git clone --recurse-submodule https://my.server/myrepos
```

Creating a bare repository (no working files):
```bash
git clone --bare  /my/original/repos /my/new/repos
```

## init

Create a git repository from current directory:
```bash
git init .
```

Creating a bare repository from current directory:
```bash
git init --bare .
```
The directory must be empty.

When creating a bare repository, it is also useful to enable sharing so other
users can push to it:
```bash
git init --bare --shared=group .
```
`group` (or `true`) will use group permissions.
`umask` (or `false`) will use umask permissions.
`all` (or `world` or `everybody`): same as group, plus everybody can read.
`0xxx`: overrides umask modes.

## status

Get status:
```bash
git status
```

List ignored files:
```bash
git status --ignored
```

## commit

 * [Changing a commit message](https://help.github.com/articles/changing-a-commit-message/).

Changing last commit message on local machine:
```bash	
git commit --amend -m "New commit message"
```

## remote

Add a remote shortcut:
```bash
git remote add origin ssh://some.server/var/git/mygitrepos
```

Rename:
```bash
git remote rename old_name new_name
```

Delete:
```bash
git remote rm my_remote
```

Get information on remote and the branches tracked locally:
```bash
git remote show my_remote
```

Change the URL of a remote:
```bash
git remote set-url remote_name new_url
```

## config

Configuring git with personal information:
```bash
git config --global user.name "Pierrick Roger"
git config --global user.email pierrick.roger@gmail.com
```
Configuration goes into `~/.gitconfig`.

Display repository configuration:
```bash
git config -l
```

Edit configuration:
```bash
git config -e
```

Define the master branch to use by default:
```bash
git config branch.master.remote origin
git config branch.master.merge refs/heads/master
```

Setting sharing permissions:
```bash
git config core.sharedRepository group
git config core.sharedRepository umask
```
`group` (or `true`) will use group permissions.
`umask` (or `false`) will use umask permissions.

## fetch

Remove locally all remote-tracking that point to remote branches that no longer
exist:
```bash
git fetch --prune
git fetch -p
```

Fetch tags:
```bash
git fetch --tags
```

## log

To get a tree view of the commits:
```bash
git log --graph  --pretty=format:\"%C(81)%h %C(15)%s %C(196)%D %C(27)%an %C(220)%ar%C(15) %C(34)%aD\" --decorate --all 
```

To get a tree view focusing on the history of a single branch:
```bash
git log --graph --abbrev-commit --decorate --first-parent mybranch
```

List commits of branch A that have not been cherry picked into branch B:
```bash
git tree --cherry B...A
```
`=` means that the commit has been cherry picked.

List commits between two commits:
```bash
git log --oneline --decorate v1.1.3..HEAD
```

Find all deleted files:
```bash
git log --diff-filter=D --summary
```

Get diffs for each step:
```bash
git log -p
```

List changes in details:
```bash
git log --stat --summary
```

Look for a version which introduce or remove a certain string:
```bash
git log -S<string> -- <file>
```

## merge

Merging another branch into the current one:
```bash
git merge my_other_branch
```

Ignore end of line characters:
```bash
git merge -Xignore-space-at-eol ...
```

Merging a repository into another one. We suppose repository A and repository B
are two completely different repositories, and they have no files in common. We
want to merge A into B. From inside repository B we run:
```bash
git remote add repos_A /my/URL/to/repos/A
git fetch repos_A
git checkout your_branch_in_which_to_merge
git merge repos_A/master --allow-unrelated-histories
git remote rm repos_A
```

## mv

Moving a submodule folder:
```bash
git mv old/submod new/submod
```
## push

Deleting a branch on a remote:
```bash
git push -d origin my_branch # Delete remotely
git push origin :my_branch   # Delete branch my_branch on remote
```

Mirroring local repository onto a remote:
```bash
git push --mirror /my/remote/repos
```

Push tags:
```bash
git push --tags ...
```

## rebase

 * [Git Branching - Rebasing](https://git-scm.com/book/en/v2/Git-Branching-Rebasing).

Rebase a branch A onto a branch B when a direct forward path is available:
```bash
git rebase B A
```
`A` can be omitted if it is the current checked out branch.

Rebase a branch A previously forked from a branch B onto a branch C for which there exists no direct forward path:
```bash
git rebase --onto C B A
```

Change an old commit:
```bash
git rebase -i HEAD~4 # If the commit is the 4th starting from HEAD.
```
This will open a list of the commits inside the default editor.
Change `pick` to `edit` on the commit line you want to modify the message.
Save and quit the editor.
Now modify your commit message by running:
```bash
git commit --amend
```
And finish rebasing:
```bash
git rebase --continue
```
If the commit was already pushed to the server, run:
```bash
git push --force
```

## reset

Remove a file from the stage area:
```bash
git reset HEAD -- myfile
```

Remove all local modifications and reset to last commit of current branch:
```bash
git reset --hard
```

Delete last local commit:
```bash
git reset --hard HEAD~1
```

Remove all last local commits on current branch:
```bash
git reset --hard @{u}
```

## rev-list

Find the last commit that affected a file:
```bash
git rev-list -n 1 HEAD -- my/file
```
This is a way to find the commit that deleted a file.

## rev-parse

Get current commit number:
```bash
git rev-parse HEAD
```

## revert

Revert a commit:
```bash
git revert my_commit_id
```

## rm

Removing a submodule:
```bash
git rm my/sub/module
```

## stash

Create a stash where all current modifications are put:
```bash
git stash push
```

List all stashes:
```bash
git stash list
```

Apply most recent stash and drop it:
```bash
git stash pop
```

## tag

Create a tag:
```bash
git tag -m "mymsg" mytagname
```

List tags:
```bash
git tag -l
```

Delete a tag locally:
```bash
git tag -d mytagname
```

Remove a tag on remote:
```bash
git push origin :refs/tags/mytag
```

Rename a tag already pushed on remote:
```bash
git tag new_tag old_tag
git push --tags
git push origin :refs/tags/old_tag
git tag -d old_tag
```
See [How to rename a tag already pushed to a remote git repo](http://blog.sidmitra.com/how-to-rename-a-tag-already-pushed-to-a-remot).

Move tag to current commit:
```bash
git tag -f mytag
```

## revisions

See `man gitrevisions`.

`@{u}` or `@{upstream}`: remote branch tracked by current local branch.
`mybranch@{u}`: remote branch tracked by mybranch.

`mybranch~`: first parent of mybranch. `~` only follows the first parent,
always.
`mybranch~~~~~` or `mybranch~5` means the 5th parent, always following the first
parent.

`mybranch^` is equivalent to `mybranch~`.
By default `^` follow also the first parent, but a number after it has a
different meaning: it means to follow the nth parent.
So `mybranch^1` is the same as `mybranch^`, and `mybranch^1^1^1^1` is the same
as `mybranch~4`.
To follow the first parent, then the third, and finally the second:
`mybranch^^3^2`.
See `man gitrevisions`, for an example with a tree.

## gitk

Display a graphical representation of the history (Tk application):
```bash
gitk . &
```

## svn

Cloning from SVN:
```bash
git svn clone ssh://username@host/path/to/svn/repos my_git_repos
git svn clone --username=<user> https://host/path/to/svn/repos my_git_repos
```

Update:
```bash
git svn rebase
```

Commit:
```bash
git svn dcommit
```

## Gnome Keyring

 * [What is the correct way to use git with gnome-keyring and http(s) repos?](https://askubuntu.com/questions/773455/what-is-the-correct-way-to-use-git-with-gnome-keyring-and-https-repos).

```bash
sudo apt-get install libgnome-keyring-dev
sudo make --directory=/usr/share/doc/git/contrib/credential/gnome-keyring
git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
```

## Cleaning

```bash
git gc --prune=now # Cleanup unnecessary files and optimize the local repository.
git remote prune origin # Deletes all stale remote-tracking branches under origin.
```

## Git clients

### GitHub

#### Wiki

Clone a wiki project (add `.wiki` suffix at the repos name):
```r
git clone git@github.com:org_or_name/repos.wiki
```

For making a link to an HTML file stored in GitHub, see:
 * [HTML Preview for GitHub Repositories](https://github.com/htmlpreview/htmlpreview.github.com).
 * [RawGit](http://rawgit.com). !! --> the URLs are permanently cached.

### Tortoise Git

Install PuTTY and msysgit (`Git-*-preview*.exe`) first.

After installing Tortoise Git, check that AutoCrlf is checked and SafeCrLf is true in Tortoise Git configuration (right-click on any directory/file, and then got to `TortoiseGit --> Settings --> Git`).

## Windows and unix line ending

How to avoid having CRLF line ending in UNIX, and LF line ending only in Windows ?

On Windows, configure:
```bash
git config --global core.autocrlf true
```
So git converts all LF to CRLF on checkout, and all CRLF to LF on commit.

On UNIX, configure:
```bash
git config --global core.autocrlf input
```
So git converts all CRLF to LF on commit.

Use `.gitattributes`, for setting the conversion type explicitly for certain binary files or file types accidentally recognized as text files.
Create a `.gitattributes` at the root of your git repository and put inside the rules you want. For instance, if you want to ignore replacement of end of lines in patch files:
```
*.patch     -text
```

## submodule

It's a little confusing to get used to this, but submodules are not on a branch. They are just a pointer to a particular commit of the submodule's repository.

This means, when someone else checks out your repository, or pulls your code, and does git submodule update, the submodule is checked out to that particular commit.

This is great for a submodule that does not change often, because then everyone on the project can have the submodule at the same commit.

If you want to move the submodule to a particular tag:
```bash
cd submodule_directory
git checkout v1.0
cd ..
git add submodule_directory
git commit -m "moved submodule to v1.0"
git push
```

Then, another developer who wants to have `submodule_directory` changed to that tag, does this:
```bash
git pull
git submodule update
```
The `git pull` command changes which commit their submodule directory points to.
The `git submodule update` command actually merges in the new code.

The submodules are listed inside `.gitmodules` file, which is the only thing commited inside repository.

### Basic operations

Adding a submodule to a project:
```bash
git submodule add <url> [name]
```
The url can be relative to the super project repository (e.g.: `../my_sub_module`).

Initializing a submodule:
```bash
git submodule init
git submodule init -- mysubmodule   # init only one submodule
```
The initialization has for aim to resolve the URL of the module and store it inside the `.gitconfig` file.

Updating a submodule:
```bash
git submodule update
git submodule update -- mysubmodule # update only one submodule
```

To update an URL of a submodule:

	1. Edit the URL in .gitmodules.
	2. run `git submodule sync`.

Updating a submodule to the most recent version:
```bash
cd sub-module
git branch master # or whatever branch you are currently working on.
git pull
cd ..
```

Run a command foreach submodule, recursively:
```bash
#git submodule foreach --recursive git pull
```

To remove a submodule you need to:

 1. Delete the relevant lines from the `.gitmodules` file.
 2. Delete the relevant section from `.git/config`.
 3. If modification have been added to stash, run `git rm --cached mymodule` to remove them (no trailing slash).
 4. Delete the now untracked submodule directory.
 5. Delete local repos in .git/modules/
 6. Commit the superproject.

## Branch 'no branch'

In a submodule obtained from running in shell the commands `git submodule init` and `git submodule update`, you're not working on a branch of the submodule (if you run git branch inside the submodule, it says 'no branch').
To work on a branch on the submodule you have to switch to one:
```bash
cd sub_module
git checkout master
```
do something...
```bash
git commit -m "..." -a
git push
cd ..
git add sub_module
git commit -m "update submodule"
git push
```

If someone else has cloned the project with submodules and want to update the repository and its submodules, he must run:
```bash
git pull
git submodule update
```

Another case of the (no branch) state, is after a rebase.
First merge your changes :
```bash
git commit -a -m ...
```
then move to master:
```bash
git checkout master
```
read the SHA ID in message:
	[detached HEAD <SHA>] <commit msg>
merge in (no branch) modifications:
```bash
git merge <SHA>
```

### Renaming a submodule

Starting from a clean cloned repository (before doing `git submodule init`, so submodule directories are empty):
```bash
git mv current_submodule_name new_submodulename
```
Then edit `.gitmodules` file and change submodule title and url:
Before:
``` {.linux-config}
[submodule "current_submodule_name"]
	path = current_submodulename
	url = ../current_submodule_name
```
After:
``` {.linux-config}
[submodule "new_submodule_name"]
	path = new_submodulename
	url = ../new_submodule_name
```
Then run:
```bash
git add .gitmodules
```

**!!! THE FOLLOWING SOLUTION DOESN'T WORK**:
Other way for renaming submodules (to be tested):
```bash
Update .gitmodules
mv oldpath newpath
git rm oldpath
git add newpath
git submodule sync
```

## LFS (Large File Storage)

 * [Storing large binary files in git repositories](http://blog.deveo.com/storing-large-binary-files-in-git-repositories/).
 * [Git LFS](https://git-lfs.github.com/).
 * [Announcing Git LFS Support in GitLab](https://about.gitlab.com/2015/11/23/announcing-git-lfs-support-in-gitlab/).

## Staging area (status, add, remove, reset)

To add files to the staging area, use the command `add`:
```bash
git add myfile  # Add one file
git add .       # Add all files, even in subfolders
```

Cancel one file addition, removing it from the staging area:
```bash
git reset HEAD myfile
```

Delete a file from disk and staging area (if it was a new file):
```bash
git rm myfile
```

Mark a file as deleted into the staging area, but keep it in your working directory:
```bash
git rm --cached my_file
```

Cancel all changes (clean index and working dir):
```bash
git reset --hard HEAD
```

Reset local branch to look like origin's one:
```bash
git reset --hard origin/mybranch
```

## Removing files and folders

 * [Permanently remove files and folders from Git repo](https://dalibornasevic.com/posts/2-permanently-remove-files-and-folders-from-a-git-repository).

Remove a folder from all commits of the current branch:
```bash
git filter-branch -f --tree-filter 'rm -rf myfolder' HEAD
git push origin -f
```

For remove a folder in all branches:
```bash
git filter-branch -f --tree-filter 'rm -rf myfolder' my list of branches
git push origin -f --all
```

## ls-files

List files:
```bash
git ls-files
```

List deleted (in comparison with HEAD) files:
```bash
git ls-files -d
```

List one precised file:
```bash
git ls-files <filename>
```

List one precised file and exit with 1 if files isn't tracked:
```bash
git ls-files <filename> --error-unmatch
```

## Archive

Create a zip of sources:
```bash
git archive HEAD --format=zip > archive.zip
```

Create a tar with a prefix directory:
```bash
git archive --prefix=prefix-dir/ -o archive.tar HEAD
```

## Case sensitivity of filenames

To change case under macOS (with default file system in case insensitive mode):
```bash
git mv filename Filename
```

## Search

Search for expression in commited code:
```bash
git rev-list --all | xargs git grep my.piece.of.code
```

## Errors

### server certificate verification failed

When clonning a repository:
```bash
git clone https://codev-tuleap.intra.cea.fr/plugins/git/phenoforge/explorair.git
```
This following error appears:
```
Cloning into 'explorair'...
fatal: unable to access 'https://codev-tuleap.intra.cea.fr/plugins/git/phenoforge/explorair.git/': server certificate verification failed. CAfile: /etc/ssl/certs/ca-certificates.crt CRLfile: none
```

A solution (quite bad), is to ignore the certificate verification:
```bash
GIT_SSL_NO_VERIFY=1 git clone https://...
```

### unable to get local issuer certificate

When clonning a repository:
```bash
git clone https://codev-tuleap.intra.cea.fr/plugins/git/phenoforge/pierricks_draft.git pierrick_phenoforge_draft
```
This following error appears:
```
Cloning into 'pierrick_phenoforge_draft'...
fatal: unable to access 'https://codev-tuleap.intra.cea.fr/plugins/git/phenoforge/pierricks_draft.git/': SSL certificate problem: unable to get local issuer certificate
```

See [SSL certificate problem: Unable to get local issuer certificate](https://confluence.atlassian.com/bitbucketserverkb/ssl-certificate-problem-unable-to-get-local-issuer-certificate-816521128.html).

### bad line length character

The exact error is:
	fatal: protocol error: bad line length character: MACP

Linked to ssh issue.
Happens when the shell, on login, write text to the console, which SSH isn't expecting. Look for the line in `~/.profile` or `~/.bashrc` or `~/.bash_profile` on remote computer.

## HEAD

On a remote repository, HEAD is used to know the default branch to use when cloning. It's a symbolic reference, which means it points to a branch, not a commit.

To change HEAD on remote, go to the remote bare repository and:
```bash
git symbolic-ref HEAD refs/heads/the_new_branch
```

## Changing master branch

1) Rename branch master in master-old
```bash
git branch -m master master-old
```

2) Delete branch master on remote. Do not forget to change remote HEAD first, before.
```bash
git push origin :master
```

3) Create master-old on remote:
```bash
git push origin master-old
```

4) Create new local branch master:
```bash
git checkout -b master another_branch_or_commit
```

5) Push new branch master on the remote:
```bash
git push origin master
```

## Restoring, recovering and reverting

For restoring a directory or a file, run gitk and find the moment in history where the directory has been removed. Note the SHA1 ID associated with this commit
Then run:
```bash
git checkout <SHA1> -- <path>
```

Recovering a file that has been deleted with `rm` command:
```bash
git checkout <file>
```

Revert a file to most recent commit:
```bash
git checkout HEAD -- <filename>
```

Revert a file to its state just before the most recent commit:
```bash
git checkout HEAD^ -- <filename>
```

## Diff

List files scheduled for addition or removal:
```bash
git diff --cached
```

Show diffs between this pull and the pull before:
```bash
git diff @{1}..
```

## Whatchanged

List files that have changed:
```bash
git whatchanged --since=yesterday 
```

Show diffs:
```bash
git whatchanged --since=yesterday -p
```

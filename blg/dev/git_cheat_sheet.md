# Working upstream

1) Clone, fork, remote upstream
* git clone https://github.com/brendangregg/perf-tools.git
* Fork project on github
* git remote add upstream https://github.com/guxtavo/perf-tools.git
* git fetch upstream

2) Work the source
* git checkout -b new_fix_for_this
* Do some change, add some files
* git add .
* git commit -a -m "new fix for this"

3) Push upstream and pull request
* git push upstream (pushes branch new_fix_for_this to upstream/
* Create a pull request on github website
* Wait for merge
* git pull (update from origin)

# rebase

(0) ptfutils (master)$ git checkout improve-variables
Switched to branch 'improve-variables'

(0) ptfutils (improve-variables)$ git rebase origin/master
Auto-merging ptfutils/ptfrepos.py
CONFLICT (content): Merge conflict in ptfutils/ptfrepos.py
error: could not apply a46fcf4... ptfrepos: improve variable names
Resolve all conflicts manually, mark them as resolved with
"git add/rm <conflicted_files>", then run "git rebase --continue".
You can instead skip this commit: run "git rebase --skip".
To abort and get back to the state before "git rebase", run "git rebase
--abort".
Could not apply a46fcf4... ptfrepos: improve variable names

# working with remotes

git remote show origin | less
git log origin/SOMETHINTG_FROM_LAST_COMMAND

# pull requests from git

Sometimes a pull request will be the patch you need for a PTF, but the pull
request was not accepted already into the master repo.

If you clone the master repo you won't be able to do a git show for that
particular pull request. In order to make the pull request available after you
clone the master, you need to check the github page for the patch, and it will
say where the pull request can be found, e.g.:

> tchaikov wants to merge 1 commit into ceph:master from tchaikov:wip-22354

So after clonning master, you need to add this pull request so you can save
the diff:

> git fetch https://github.com/tchaikov/ceph wip-22354

## my tips

# how to make diff between branches

    git diff master Branch1 > ../patchfile
    git checkout Branch2
    git apply ../patchfile

## working with tags

* git checkout v4.4.60
* git checkout master

To sum it up: executing commands below is basically equivalent to fresh git
clone from original source (but it does not re-download anything, so is much
faster):

    git reset
    git checkout .
    git clean -fdx

If you wish to "undo" all uncommitted changes simply run:

    git stash
    git stash drop

# print remote repos

    git remote -v
    git branch --remote --list

# update repo

    git fetch --all
    git pull

# reports
# number of commits in a period of time

    git log --oneline --since='4 month ago' --until='now' | wc -l

# show adds and deletes for each file
# how to treat this data and sumarize report

    git log --numstat --oneline --since='1 day ago' --until='now'
    git log --numstat --oneline --since='1 week ago' --until='now'
    git log --numstat --oneline --since='1 month ago' --until='now'
    git log --numstat --oneline --since='3 month ago' --until='now'
    git log --numstat --oneline --since='1 year ago' --until='now'

# view head revision of a file

    git show HEAD:path/to/file

How to see the content of a remote branch:

    $ git ls-remote --heads origin | grep mkubecek

    b6e09444cde19c9757c4c75a3f2c4cb775b7ff60 refs/heads/users/mkubecek/SLE11-SP3-LTSS/979950
    e275b90a93aef912d92d5e3b65bd17486e5b7ae8 refs/heads/users/mkubecek/SLE11-SP4/1010175
    64bf3a7f6eb131921ba145ad07fbce6a917fcc54 refs/heads/users/mkubecek/SLE11-SP4/1010175-2
    3aadb95245c7dde3598800fc11953c7df592806a refs/heads/users/mkubecek/SLE11-SP4/1030814
    b399d0a3e5326f6f1bcfaad5fb8f7744d4687b8a refs/heads/users/mkubecek/SLE11-SP4/1070078
    8e2186808c1123eb0d587524076b118f70d9aa7e refs/heads/users/mkubecek/SLE11-SP4/977687
    212a226207704bbe99d5b25e3d42320cb1afc30b refs/heads/users/mkubecek/SLE11-SP4/979514
    ec0c93ceacf94a4a9d29e259f2246879a332b0a1 refs/heads/users/mkubecek/SLE12-LTSS/1034075

    $ git show ec0c93ceacf94a4a9d29e259f2246879a332b0a1









## cia wikileaks

The "I can never remember that alias I set" Trick

[alias]
	aliases = !git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /' | sort

Gitignore

$ git config --global core.excludesfile ${HOME}/.gitignore

Then create a ~/.gitignore. .gitignore follows glob syntax

The "The Git URL is too long" Trick

('excerpt-include' missing)

The "I forgot something in my last commit" Trick

# first: stage the changes you want incorporated in the previous commit

# use -C to reuse the previous commit message in the HEAD
$ git commit --amend -C HEAD
# or use -m to make a new message
$ git commit --amend -m 'add some stuff and the other stuff i forgot before'

The "Oh crap I didn't mean to commit yet" Trick

# undo last commit and bring changes back into staging (i.e. reset to the commit one before HEAD)
$ git reset --soft HEAD^

The "That commit sucked!  Start over!" Trick

# undo last commit and destroy those awful changes you made (i.e. reset to the commit one before HEAD)
$ git reset --hard HEAD^

The "Oh no I should have been working in a branch" Trick

# takes staged changes and 'stashes' them for later, and reverts to HEAD.
$ git stash

# creates new branch and switches to it, then takes the stashed changes and stages them in the new branch.   fancy!
$ git stash branch new-branch-name

The "OK, which commit broke the build!?" Trick

# Made lots of local commits and haven't run any tests...
$ [unittest runner of choice]
# Failures... now unclear where it was broken.

# git bisect to rescue.
$ git bisect start # to initiate a bisect
$ git bisect bad   # to tell bisect that the current rev is the first spot you know was broken.
$ git bisect good <some tag or rev that you knew was working>
$ git bisect run [unittest runner of choice]
# Some runs.
# BLAMO -- git shows you the commit that broke
$ git bisect reset #to exit and put code back to state before git bisect start
# Fix code. Run tests. Commit working code. Make the world a better place.

The "I have merge conflicts, but I know that one version is the correct one" Trick, a.k.a. "Ours vs. Theirs"

# in master
$ git merge a_branch
CONFLICT (content): Merge conflict in conflict.txt
Automatic merge failed; fix conflicts and then commit.
$ git status -s
UU conflict.txt

# we know the version of the file from the branch is the version we want.
$ git checkout --theirs conflict.txt
$ git add conflict.txt
$ git commit

# Sometimes during a merge you want to take a file from one side wholesale.
# The following aliases expose the ours and theirs commands which let you
# pick a file(s) from the current branch or the merged branch respectively.
#
# N.b. the function is there as hack to get $@ doing
# what you would expect it to as a shell user.
# Add the below to your .gitconfig for easy ours/theirs aliases.
#    ours   = "!f() { git checkout --ours $@ && git add $@; }; f"
#    theirs = "!f() { git checkout --theirs $@ && git add $@; }; f"

The "Workaround Self-signed Certificates" Trick

This trick should no longer be necessary for using Stash, so long as you have the certificate for DEVLAN Domain Controller Certificate Authority installed.

# Issue: When attempting to clone (or any other command that interacts with the remote server) git by default validates
# the presented SSL certificate by the server.  Our server's certificate is not valid and therefore git exits out with an error.
# Resolution(Linux): For a one time fix, you can use the env command to create an environment variable of GIT_SSL_NO_VERIFY=TRUE.
$ env GIT_SSL_NO_VERIFY=TRUE git <command> <arguments>


# If you don't want to do this all the time, you can change your git configuration:
$ git config --global http.sslVerify false

Split a subdirectory into a new repository/project

$ git clone ssh://stash/proj/mcplugins.git
$ cd mcplugins
$ git checkout origin/master -b mylib
$ git filter-branch --prune-empty --subdirectory-filter plugins/mylib mylib
$ git push ssh://stash/proj/mylib.git mylib:master


Local Branch Cleanup

# Delete local branches that have been merged into HEAD
$ git branch --merged | grep -v '\\*\\|master\\|develop' | xargs -n 1 git branch -d
# Delete local branches that have been merged into origin/master
$ git branch --merged origin/master | grep -v '\\*\\|master\\|develop' | xargs -n 1 git branch -d
# Show what local branches haven't been merged to HEAD
$ git branch --no-merged | grep -v '\\*\\|master\\|develop'

=== Lightning talk ===

use cases:
1) Search patches in between kernel versions
2) Inspect patches
3) Inspecting files from a given version

git tag - list tags

git checkout kernel-3.10.0-327.el7 - checkout a specific tag for inspection

git status - check which tag you are on

git checkout master - go back to master

git grep "hung task" - grep

git log --oneline kernel-3.10.0-327.el7.. - list patches, in one line format,
from tag until master

git log --oneline kernel-3.10.0-327.el7..kernel-3.10.0-327.9.1.el7 - list patches, in one line format, from tag until tag

git log --oneline kernel-3.10.0-327.el7..kernel-3.10.0-327.9.1.el7
security/keys/process_keys.c - list patches, in one line format, from tag
until tag in a specific file

git show 0637fcf - show detailed information about a patch

git status -s  				# short
git log -p    				# diffs
git log --stat				# diffstat
git log --shortstat			# short diffstat
git log --oneline			# short sha1
git log --pretty="oneline"	# full sha1
git log --pretty="fuller"	# fuller
git log --graph				# branch and merge history
git commit --ammend			# ammend a commit
git reset HEAD file			# unstage a file, keeping the modifications
git checkout -- file		# reset to working directory last commit version
git push [remote] [branch]	# origin and master are set at pull, so, not needed

	$ git log --pretty=format:"%h - %an, $ar : %s"
	38d6496 - Gustavo Figueira, 3 days ago : fix 80_columns.sh for OpenBSD + new article
	4eafa19 - Gustavo Figueira, 3 days ago : 2019-04-02 update

format options

	%H commit hash                 %ad author date
	%h abbreviated commit hash     %ar author date, relative
	%T tree hash                   %cn committer name
	%t abbreviated tree hash       %ce committer email
	%P parent hash                 %cd committer date
	%p abbreviated parent hash     %cr committer date, relative
	%an author name                %s subject
	%ae author email

# limiting output

	--since="2008-01-14"
	--until="2 years 1 day 3 minutes ago"
	--author
	--grep
	-S
	path

#!/bin/sh

if [ "`git status -s`" ]
then
	    echo "The working directory is dirty. Please commit any pending changes."
	        exit 1;
	fi

	echo "Deleting old publication"
	rm -rf www/public
	mkdir www/public
	git worktree prune
	rm -rf .git/worktrees/www/public/

	echo "Checking out gh-pages branch into public"
	git worktree add -B gh-pages www/public origin/gh-pages

	echo "Removing existing files"
	rm -rf www/public/*

	echo "Generating site"
	cd www
	hugo

	echo "Updating gh-pages branch"
	cd public && git add --all && git commit -m "Publishing to gh-pages (publish.sh)"

  cd ..
  cd ..
	#echo "Pushing to github"
	#git push --all

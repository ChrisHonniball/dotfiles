# VIM Settings

My Personal VIM Settings

## Installing VIM Setup on alternate machine

```
cd ~
git clone https://github.com/CreativLogic/vim-settings.git .vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
cd ~/.vim
git submodule update --init
```

## Submodules

### Installing Submodules

`git submodule add https://github.com/kien/ctrlp.vim.git ctrlp`

### Updating a Submodule

```
cd ~/.vim/bundle/fugitive
git pull origin master
```

### Upgrading All Submodules at Once

```
git submodule foreach git pull origin master
```

### Removing Submodules

[Thanks to David Walsh](http://davidwalsh.name/git-remove-submodule)

1. Delete the relevant section from the `.gitmodules` file.  The section would look similar to:

	```
	[submodule "vendor"]
		path = vendor
		url = git://github.com/some-user/some-repo.git
	```

2. Stage the `.gitmodules` changes via command line using: `git add .gitmodules`

3. Delete the relevant section from `.git/config`, which will look like:

	```
	[submodule "vendor"]
		url = git://github.com/some-user/some-repo.git
	```

4. Run `git rm --cached path/to/submodule`. Don't include a trailing slash -- that will lead to an error.
5. Run `rm -rf .git/modules/submodule_name`
6. Commit the change.
7. Delete the now untracked submodule files `rm -rf path/to/submodule`.

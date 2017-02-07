# Git isn't that Hard
*Jan. 25, 2017*

Here is a slowly growing summary of Git settings I use and commands I find helpful, with short explanations following them, addressed to the dear reader in second person.

I claim no intention to make it a complete table, even in the most rudimentary sense. What I have supposed to be useful, I summary and explain here, and what I have not, I do not. It has not been long since I started to learn to use Git, and many point are simply paraphrased from some Stack Overflow answer. Thus, I encourage and deeply appreciate that the reader shall remind me of every error.

I use Mac OS (presently Sierra) on MacBook Air. I will then focus on Mac instructions, but Unix-like users shall find no difficulty in finding their counterpart. From now on, by convention, commands meant to be run in a Bash shell is prefixed with a `$` for clarity, as goes the tradition. If you don't know what that is, just open the Terminal.app, copy and paste whatever I quoted (without `$`), and hit the Return key.

Git commands require the current working directory set to be either the top directory or any subdirectory of it, except those inside `.git/`. There are workarounds if you really don't want to do this, but I guess it is safest just to always go (by `cd`) into the top directory. This will be assume true hereafter.

Before we continue, keep in mind that Git comes with a detailed manual. If you have any question of `fetch`, for example, open Git man pages by:

    $ git help fetch

Or equivalently, 

    $ git fetch --help

## Installing Git

In Mac, Xcode is built-in. Xcode includes Command Line Tools, which in turn includes Git. In case you need to install Xcode, find it in App Store.

However, Xcode takes up a lot of space (10G at least), so if you don't develop software for Mac, you may well uninstall it, along with relevant libraries. You can still install Command Line Tools for Xcode only. To do this,

    $ xcode-select --install

You may also directly install Git using Homebrew:

    $ brew install git

To check current version, so that you know whether update is successful:

    $ git --version

Beware that Mac user may not be allowed to overwrite the built-in binary that came with Xcode. If you are determined to overwrite,

    $ brew link --overwrite git

To make sure this is effective, you may check current location of binary:

    $ which git

if the result is `/usr/bin`, then this `git` is the built-in one. If it is `/usr/local/bin`, this `git` must have been the one you installed.

## Basic Concepts

It is best that the reader take some time understanding the underlying mechanism of Git, so that from now on we can better describe its operations and grasp their meaning. I suspect many popular conceptions, being simplications, are wrong in a strict sense, and unfortunately, they often bewilder rather than clarify things for the reader.

* A *tree* is an aggregate of nodes, each of which contains a pointer of its own child or children, if any.

* A *blob* is an opaque binary file that records the the content of a file in the manner Git may read.

* A *tree object* is a representation of directory. Each subdirectory of its is represented by another tree that it points to, and each file of its by a blob that it points to.

* A *working tree* is the totality of actual source files you are working on. All you see and edit (using Git or not) belongs to the working tree. For convenience, I say that there is a *top directory* which is the minimal directory that encompasses the working tree.

* A *local repository* (local repo) is a subdirectory in the working tree named `.git/`. Everything Git needs is saved inside the local repo.

* An *index* lists files in the working tree Git is aware of. The index is saved in the local repo. We say that Git *tracks* these indexed files.

* When you *commit*, you create a blob called *commit object* that includes sufficient information to describe the present working tree, along with a unique *hash* generated according to the author, time stamp, file contents, among other figures.

* Commits are linked to each other according to respective historical relation, which makes up a *commit history*.

* A *stash* is a commit object not yet committed.

* When you *clone* a repo, you you create a copy of it.

* When you *fork* a repo, you clone it and modify it, thus generating two diverging versions, and subsequently different histories occur.

* When you fork you own local repo, you create a *branch*. Even if the local repo has not branched, we also say there is only one branch called *master*.

* A *remote repository* (remote repo) plays a similar role to local repo, but is store in an Git hosting service, like GitHub. It stores a working tree and commit history.

* When you *push*, you download files from the remote repo to to those of local repo.

* When you *pull*, you upload files from the local repo to those of remote repo.

# Creating Repos

## Creating Local Repo

Now let us say that there is a directory called `~/templates_configs_notes`. Run `cd` into it:

    $ cd ~/templates_configs_notes

and generate local repo with:

    $ git init

Following our example, the local repo will be named `~/templates_configs_notes/.git`.

Remember that nothing affects the remote repo unless you push. The implication is that if you have screwed up something and want to start anew from the very beginning, willing to abandon the not-yet-pushed changes in the working tree, you can simply delete the whole `/.git` and `git init` again.

## Creating Remote Repo

To create a new remote repo, sign up a Git service provider if you haven't. No wonder the most popular choice is [GitHub](https://github.com/). But [Bitbucket](https://bitbucket.org/) is also widely used. The difference that concerns average user most is probably that Bitbucket offers unlimited private repositories for free while GitHub does not, but that Bitbucket limits number of users for free to 5 while GitHub does not. You may well sign up both, taking their respective advantage.

The following instructions apply to GitHub, but you get the main idea. In your personal homepage, click the plus sign on the upper right corner, and choose "New repository".

When you name your remote repo, note that GitHub disallow special characters, and forbids even underscores, but allows hyphen. I deem it a good convention to name local repo with underscore-separated words, and remote repo with the same name with hyphen-separated words. Traditionally repos are named all in lower case. Following the above example, let us call it `templates-configs-notes`.

GitHub offers two protocals: `https` and `ssh`. More on this on a later section. For now, enter the page for the repo, and click the green button "Clone or download". If the small title reads "Clone with HTTPS", there is a url that looks like

    https://github.com/aminopterin/templates_configs_notes.git

Click "Use SSH", and you will see something like

    git@github.com:aminopterin/templates_configs_notes.git

To set remote url, go back to your terminal emulator. If you decide to use SSH, set

    $ git remote set-url origin git@github.com:aminopterin/templates_configs_notes.git

In other words, the remote url is abbreviated as `origin`.

To list currently existent remote repo(s):

    $ git remote -v

The result will look like:

    origin  git@github.com:aminopterin/templates_configs_notes.git (fetch)
    origin  git@github.com:aminopterin/templates_configs_notes.git (push)

To see more information in order to trouble-shoot, you may

    $ git remote show origin

## To Commit and Push

### To Compare

Before committing, it is helpful to see what new work was done. To show modification not added to the index, that is, differences between working tree and the files as was indexed:

    $ git diff

If new work has been added to the index, you can still compare the files as was index with latest commit in the local repo,

    $ git diff --staged

Instead, to compare a specific file in the working tree with the committed version of it in the local repo, say `README.md`,

    $ git diff HEAD README.md

where `HEAD` is a pointer to the latest commit.

### Navigating `diff` result

After any of these, you will see a new page that summarizes modified lines, and what is changed.

Navigation commands are identical to `less`, and similar to Vim. Hit `j`, `e` or `^e` to forward one line (where `^` stands for Control key). Hit `k`, `y`, or `^y` to backward one line. Hit `f` or `^f` to forward one window. Hit `b` or `^b` to backward one window. Hit `d` or `^d` to forward one-half window. Hit `u` or `^u` to backward one-half window. Hit `q` or `:q` to quit. 

### Updating the Index

If there are new files created or old files deleted, run this to update the index according to the present working tree:

    $ git add -A

The following does almost the same, except in that it ignores files in a newly created folder:

    $ git add .

### To Commit

Before you commit, you may want to see a short summary of what files are changed and deleted, with

    $ git status

To commit, use `git commit`. However a commit message is strongly recommended, which reminds you what you have done. For example,

    $ git commit -m "Rename files using new convention"

Summarize your work concisely, less than some 70 characters. If you cannot do this, you should have probably split your work into two or more commits. It is the tradition that, to save space, verbs in base form are used, and no period is in the end.

You can modify your commit message even after you commit, with

    $ git commit --amend

Now, an editor opens, showing the commit message in the beginning, where you may revise it. I find it useful to edit here because you don't have to backslash-escape special characters, which may occur in verbatim expressions. You can also add more explanatory lines below. The status is shown again as commented lines to recapitulate for you. This file is saved as `.git/COMMIT_EDITMSG`.

### To View Commit Log

Afterwards, you can view the commit log with

    $ git log

The result shows commit IDs, authors, time stamps, and commit messages.
To make the log more concise and informative,

    $ git log --all --decorate --oneline --graph

The names of option are pretty explanatory. Mnemonic: "a dog".

### To Push

To 

    $ git push origin master

i.e., push commits from the local repo to the master branch in the remote repo (`origin`). Say yes, if you are asked that whether you should consider the RSA host key for GitHub's IP address as a safe one.

If you have messed up something, and Git is unable to ancestral relation and thus refuses to push, you may try

    $ git push origin master

This forces everything in question in the local repo to overwrite its counterpart in the remote repo, and may cause the remote repo to lose data, so use it with caution.

## Branching and Manipulation

### To Clone and Fork

### To Create New Branch

### To Merge

### 

## Configuring Git

Keep in mind that it is the same thing to run, in the terminal,

    $ git config --global foo.bar quux

as to append the line

    [foo]
        bar = quux

to `~/.gitconfig` (the second line should start with a tab). I will use the former command in the following.

### Ignoring Some Files

It is not in general Git's purpose to track binary files. Binary files cannot be compared by utility `diff`, thus cannot be merged or rebased in the normal sense. So you don't track binary files unless some routine really needs it, and so it must be upload to the remote repo. For example, a logo of your program that you want those who clone to see.

To tell Git to ignore specified files, all files in some folders, or all files having a certain extension, create a file named `.gitignore` in the top directory. If, for sake of illustration, your `.gitignore` has these lines,

    .DS_Store
    *.pdf
    sketch/

Then the `.DS_Store` file in the top directory of local repo, all `.pdf` files anywhere in the repo, and all files in the folder called `sketch/` in the top directory, will be ignored by Git. You can play around with wildcard `*`.

### Specifying Text Editor for Commit Message


The default editor for commit message is vi. However, some of the lines in my `.vimrc` is not compatible with vi (which is normal), and Vim is used anyway with wrong color settings.

To set Vim as the commit message editor, put these in `~/.bashrc`:

    export VISUAL=vim
    export EDITOR="$VISUAL"

You can set it to be your favorite editor.

Alternatively, you can specify the editor in Git's part, with

    $ git config --global core.editor "vim"

### Color 

To color Git's console output,

    $ git config --global color.ui auto

All the various `color.*` (where `*` is wildcard) configurations available with git commands, will then be set. The `auto` makes sure Git try only those colors the current terminals emulator supports. When a command is used for the first time, relevant color configuration is be set.

### Rendition of non-ASCII Characters

By default, non-ASCII characters, such as Chinese characters, are backslash-escaped according to C-styled character codes. For example, "我" becomes `\346\210\221`. To show them as verbatim,

    $ git config --global core.quotepath false

### Generating SSH Key and Automatic Login

HTTPS and SSH differ in several aspects. On one hand, in the presence of a firewall, HTTPS port is almost always open, while SSH port is not, being often blocked by network firewalls. On the other hand, an SSH Key is more secure in that, under SSH protocol, the user does not actually login, but under HTTPS he or she has to login.

Under SSH protocol, authentication of SSH Key is easily managed by an `ssh-agent`, while under HTTPS, the user may also use a credential helper, which I have not tried.

To generate an SSH key for RSA cryptosystem, having 4096 bits, with your email specified,

    $ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

You will be asked for the filename with path (by default, `~/.ssh/id_rsa`), and a passphrase. Since with an SSH-agent you have only to type the passphrase once, you may well choose a reasonably long (some 6-word) phrase. Special characters are not only allowed, but encouraged.

If you have several keys, you may rename the public key (the one with extension `.pub`) and private key (the one without), but they must have the same name except for extension. Let us rename it `rsa_github.pub` with `mv ~/.ssh/id_rsa ~/.ssh/rsa_github.pub`.

Browse your GitHub account, and go to "Personal settings", and then "SSH and GPG keys". Click "New SSH key". Copy and paste the whole content of your public key, or more simply,

    $ cat ~/.ssh/rsa_github.pub | pbcopy

and paste into the box.

To let Keychain remember the key, in `~/.ssh/config` append `UseKeychain yes` after the relevant lines (omitted lines shown as `...`)

    Host github.com
       User git
       ...
       UseKeychain yes

Hopefully, you will never be asked for passphrase.

## More Information

* The Git [Documentation](https://git-scm.com/documentation)

    This is the documentation on the official homepage of Git. Same material may be found in `man` pages that are included in the Git package itself, to quote the site.

* Richard E. Silverman (2013). *Git Pocket Guide*. Sebastopol, CA: O’Reilly Media.

    Guides for Git are abundant. This is a readable short guide that may both be read from cover to cover, and looked up as reference.

* [Git—The Simple Guide](http://up1.github.io/git-guide/index.html)

    A table of for the most common Git commands, and very brief explanations for them. On the site, there is a downloadable PDF version.

* [Stack Overflow](http://stackoverflow.com)

    Stack Overflow is still the most likely place you end up with if you google your problem, but, since everyone can submit, you should take their advice with a grain of salt.

Alright. Maybe Git really is *that* hard.

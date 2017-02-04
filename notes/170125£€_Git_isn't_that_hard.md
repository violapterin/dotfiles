# Git isn't that Hard
*Jan. 25, 2017*

£Here are Git settings and commands I find useful, with short explanations addressed to the reader in second person.


£I claim no intention to make it a complete table, even in the most rudimentary sense. What I have supposed to be helpful, I summary and explain here, and what I have not, I do not. It has not been long since I started learning to use Git, and I appreciate the reader to remind me of any error.

£I use Mac OS (presently Sierra) on MacBook Air. From now on, commands meant to be run in Bash shell is prefixed with a `$` for clarity. In plain words, Mac users may open the Terminal.app and copy any command I mentioned (without `$`), and paste it, and hit enter.

## Installing Git

* In Mac, Xcode is built-in. Xcode includes Command Line Tools, which in turn includes Git. In case you need to install Xcode, find it in App Store.

    However, Xcode takes up a lot of space, so if you don't develop software for Apple, you may want to uninstall it. You can still install Command Line Tools for Xcode only even if you don't install Xcode. To do this,

        $ xcode-select --install

* You may also directly install Git using homebrew:

        $ brew install git

    But Mac may not allow the user to overwrite the built-in binary that came with Xcode. If you are sure to overwrite,

        $ brew link --overwrite git

* To check current location of binary,

        $ which git

    if the result is `/usr/bin`, then this `git` is built-in. If it is `/usr/local/bin`, this `git` is user-installed.


* To check current version, so that you know whether update is successful:

    git --version

# Basic Concepts

It is best that the reader take some time and understanding the underlying mechanism of Git, so that we can better describe its operations and grasp their meaning.

* A *tree* is an aggregate of nodes, each of which contains a pointer of its own child or children, if any.

* A *working tree* is the actual source files you are working on. All you see and edit (using Git or not) belongs to the working tree.

* A *blob* is an opaque binary file that records the the content of a file in the manner Git may read.

* A *tree object* is a representation of directory. Each subdirectory of its is represented by another tree that it points to, and each file of its by a blob that it points to.

* An *index* lists files in the working tree.

* When you *commit*, you link the tree objects representing the working tree into another database, called a *local repository* (local repo).

* Every commit is identified with a unique *hash* of file contents and related information. Commits are linked to each other according to respective relation, which makes up a *commit history*.

* A *stash* is the collection of objects not yet committed.

* A *remote repository* (remote repo) stores the same thing as local repo in the space that an online platform, like GitHub, offers.

* When you *push*, you download files from the remote repo to to those of local repo.

* When you *pull*, you upload files from the local repo to those of remote repo.

# Creating Local and Remote Repos

* Before we continue, remember that Git has detailed documentation built in. To open Git man pages, say of `fetch`,

        $ git help fetch

Or equivalently, 

        $ git fetch --help

* Now let us say that there is a directory called `~/templates_configs_notes`. Run `cd` into it:

        $ cd ~/templates_configs_notes

and generate `~/templates_configs_notes/.git/` directory to hold Git-relavent files, with:

        $ git init

    Remember that everything Git needs is saved inside the directory `~/templates_configs_notes/.git/`, and nothing affects the remote repo unless you push. The implication is that if you have screwed up something and want to start anew from the very beginning, willing to abandon the not-yet-pushed changes in the working tree, you can simply delete `some_code/.git/` and `git init` again.

* To create a new remote repo, sign up a Git service provider if you haven't. No wonder the most popular choice is [GitHub](https://github.com/). [Bitbucket](https://bitbucket.org/) is also widely used. The greatest difference relevant to average user is probably that Bitbucket offers unlimited private repositories for free while GitHub does not, but that Bitbucket limits number of users to 5 for free while GitHub does not. In short, sign up both.

    The following instructions apply to GitHub, but the main idea is similar. In your personal homepage, click the plus sign on the upper right corner, and choose "New repository".

* Name your repo. Note that GitHub disallow special characters, and forbids even underscores, but allows hyphen. It sounds good to name local repo with underscore, and remote repo the same name replaced with hyphen. Traditionally repos are named all in lower case. Following the above example, let us call it `templates-configs-notes`.

* GitHub offers two protocals: `https` and `ssh`.

Enter the page for the repo, and click the green button "Clone or download". If the small title reads "Clone with HTTPS", there is a url that looks like

        https://github.com/aminopterin/templates_configs_notes.git

Click "Use SSH", and you will see something like

        git@github.com:aminopterin/templates_configs_notes.git

* To set remote url, go back to your terminal emulator (with current working directory in the working tree), and run

        $ git remote set-url origin git@github.com:aminopterin/templates_configs_notes.git

    In other words, the remote url is abbreviated as `origin`.

* To list currently existent remote repo(s):

        $ git remote -v

    The result will look like:

        origin  git@github.com:aminopterin/templates_configs_notes.git (fetch)
        origin  git@github.com:aminopterin/templates_configs_notes.git (push)


## Setting up Git


    https://github.com/aminopterin/templates_configs_notes.git


* The default editor for commit message is vi. However, some of the lines in my `.vimrc` is not compatible with vi (which is normal), and Vim is used anyway with wrong color settings. To set Vim as the commit message editor, put these in `~/.bashrc`:

    export VISUAL=vim
    export EDITOR="$VISUAL"

To color Git's console ouput,

    $ git config --global color.ui auto

In 

All the various `color.*` (where `*` is wildcard) configurations available with git commands, will then be set. The `auto` makes sure Git try those colors the current terminals emulator support. When a command is used, relevent color configuration will then be set.

This effectively generates these lines in `~/.gitconfig`:

    [color]
        ui = auto

Equivalently, you may modify `~/.gitconfig` directly.

If you want to be specific, run, for example,

    $ git config --global color.branch auto
    $ git config --global color.status auto
    $ git config --global color.diff auto

Or equivalently, add these lines in `~/.gitconfig`:

    branch = auto
    status = auto
    diff = auto

	branch = auto	status = auto



    git@github.com:aminopterin/templates_configs_notes.git

    git remote set-url origin https://github.com/USERNAME/OTHERREPOSITORY.git

    git commit -m "Write commit message here"

    git commit --amend

.git/COMMIT_EDITMSG"

By default, unusual characters, such as Chinese characters, are backslash-escaped according to C-styled convention. For example, "我" becomes "\346\210\221". To show them as verbatim,

    git config --global core.quotepath false

Or equivalently, 

    git log

    git log --all --decorate --oneline --graph

* To compare modification not added to the index with previous commit,

        git diff

    To compare

        git diff

if new work has been added to the index, you can still compare 

    git diff --staged


You will see a new page that shows modified lines, and what is changed. Navigation commands are identical to `less`, and similar to Vim. Hit `j`, `e` or `^e` to forward one line (where `^` stands for Control key). Hit `k`, `y`, or `^y` to backward one line. Hit `f` or `^f` to forward one window. Hit `b` or `^b` to backward one window. Hit `d` or `^d` to forward one-half window. Hit `u` or `^u` to backward one-half window. Hit `q` or `:q` to quit. 


# Basic Usage



## More Information

* The Git [Documentation](https://git-scm.com/documentation)

    This is the documentation on the official homepage of Git. Same material may be found in `man` pages that are included in the Git package itself, to quote the site.

* Richard E. Silverman (2013). *Git Pocket Guide*. Sebastopol, CA: O’Reilly Media.

    Guides for Git are abundant. This is a short guide that may both be read from cover to cover, and looked up as reference.

* [Git—The Simple Guide](http://up1.github.io/git-guide/index.html)

    A table of for the most common Git commands, and very brief explanations. On the site, there is a downloadable PDF version.

* [Stack Overflow](http://stackoverflow.com)

    Stack Overflow is still the most likely place you end up with if you google your problem, but, since everyone can submit, you should take their advice with a grain of salt.

Alright. Maybe Git really is *that* hard.


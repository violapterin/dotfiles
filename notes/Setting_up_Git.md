# Setting up Git
*Jan. 25, 2017*

Here is a memorandum for Git settings I use. I hope that this helps future newcomers to Git find information sometimes hard to look up.

It has not been long since I started to learn to use Git, and many point are simply paraphrased from some Stack Overflow answer. Thus, I encourage and deeply appreciate that the reader shall remind me of every error.

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

To set remote url, go back to your terminal emulator. First you have to create an abbreviation of the remote url called `origin`. If you decide to use SSH, use

    $ git remote add origin git@github.com:aminopterin/templates_configs_notes.git

If you have to change url later, use `set-url`.

    $ git remote set-url origin git@github.com:aminopterin/templates_configs_notes.git

To list currently existent remote repo(s):

    $ git remote -v

The result will look like:

    origin  git@github.com:aminopterin/templates_configs_notes.git (fetch)
    origin  git@github.com:aminopterin/templates_configs_notes.git (push)

To see more information in order to trouble-shoot, you may

    $ git remote show origin

## Configuring Git

Keep in mind that it is the same thing to run, in the terminal,

    $ git config --global foo.bar quux

as to append the line

    [foo]
        bar = quux

to `~/.gitconfig` (the second line should start with a tab). I will use the former form in the below.

## Ignoring Some Files

It is not in general Git's purpose to track binary files. Binary files cannot be compared by utility `diff`, thus cannot be merged or rebased in the normal sense. So you don't track binary files unless some routines really need it, and so it must be uploaded to the remote repo. For example, a logo of your program that you want those who clone to see.
Create a file named `.gitignore` in the top directory to tell Git to ignore specified files, all files in specified directories, or all files having specified extension. If, for sake of illustration, your `.gitignore` has these lines,

    .DS_Store
    *.pdf
    sketch/

Then the `.DS_Store` file in the top directory of working tree, all `.pdf` files anywhere in the working tree, and all files in the subdirectory called `sketch/` in the top directory, will be ignored by Git. You can play around with wildcard `*`.

## Specifying Text Editor for Commit Message

The default editor for commit message is vi. However, some of the lines in my `.vimrc` is not compatible with vi (which is normal), and Vim is used anyway with wrong color settings.

To set Vim as the commit message editor, put these in `~/.bashrc`:

    export VISUAL=vim
    export EDITOR="$VISUAL"

You can replace with your favorite editor.

Alternatively, you can specify the editor not through Bash's setting but through Git's, with

    $ git config --global core.editor "vim"

## Color 

To color Git's console output,

    $ git config --global color.ui auto

All the various `color.*` (where `*` is a wildcard) configurations available with git commands, will then be set. The `auto` makes sure Git try only those colors the current terminals emulator supports. When a command is used for the first time, relevant color configuration is set.

## Rendition of non-ASCII Characters

By default, non-ASCII characters, such as Chinese characters, are backslash-escaped according to C-styled character codes. For example, "我" becomes `\346\210\221`. To show them as verbatim,

    $ git config --global core.quotepath false

## Generating SSH Key and Automatic Login

HTTPS and SSH differ in several aspects. On one hand, in the presence of a firewall, the HTTPS port is almost always open, while the SSH port is not, being often blocked by network firewalls. On the other hand, an SSH Key is more secure in that, under SSH protocol, the user does not actually login, but under HTTPS he or she has to login.

Under SSH protocol, authentication of SSH Key is easily managed by an `ssh-agent`, while under HTTPS, the user may also use a credential helper, which I have not tried.

To generate an SSH key for RSA cryptosystem, having 4096 bits, with your email specified,

    $ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

You will be asked for the filename with path (by default, `~/.ssh/id_rsa`), and a passphrase. Since with an SSH-agent you have only to type the passphrase once, you may well choose a reasonably long (say, some 6-word) phrase. Special characters are not only allowed, but in fact encouraged.

If you have several keys, you may rename the public key (the one with extension `.pub`) and private key (the one without), but they must share the same name except for extension. Let us rename it `rsa_github.pub` with `mv ~/.ssh/id_rsa ~/.ssh/rsa_github.pub`.

Browse your GitHub account, and go to "Personal settings", and then "SSH and GPG keys". Click "New SSH key". Copy and paste the whole content of your public key, or more simply,

    $ cat ~/.ssh/rsa_github.pub | pbcopy

and paste it into the box.

To let Keychain remember the key, in `~/.ssh/config` append `UseKeychain yes` after the relevant lines (omitted lines shown as `...`)

    Host github.com
       User git
       ...
       UseKeychain yes

Hopefully, you will never be asked for passphrase.

## Reminding GitHub the correct language

GitHub guesses the language in which most sources in your repo is written in. A comprehensive list is found [here](https://gitlab.com/gitlab-org/linguist/blob/master/lib/linguist/languages.yml). The language is shown besides a round dot in each repo in your own profile page.

If you would like to use an idiosyncratic extension, GitHub may judge it wrongly. For example, GitHub does not recognize `.hpp` as C++ header. To prevent this, you add a file named `.gitattributes` in the top directory, with content

    *.hpp linguist-language=C++

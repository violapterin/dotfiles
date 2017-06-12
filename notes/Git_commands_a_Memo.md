# Git Commands: A Memo
*Feb. 6, 2017*

Here is a slowly growing summary of Git commands I find helpful, with short explanations following them, addressed to the dear reader in second person. The reader may want to read "Setting up Git" first for relevant background.

I claim no intention to make it a complete table, even in the most rudimentary sense. What I have supposed to be useful, I summary and explain here, and what I have not, I do not. Again, I appreciate anyone to correct my misunderstandings, if any.

I use Mac OS (presently Sierra) on MacBook Air. I will then focus on Mac instructions, but Unix-like users shall find no difficulty in finding their counterpart. From now on, by convention, commands meant to be run in a Bash shell is prefixed with a `$` for clarity, as goes the tradition. If you don't know what that is, just open the Terminal.app, copy and paste whatever I quoted (without `$`), and hit the Return key.

Git commands require the current working directory set to be either the top directory or any subdirectory of it, except those inside `.git/`. There are workarounds if you really don't want to do this, but I guess it is safest just to always go (by `cd`) into the top directory. This will be assume true hereafter.

Before we continue, keep in mind that Git comes with a detailed manual. If you have any question of `fetch`, for example, open Git man pages by:

    $ git help fetch

Or equivalently, 

    $ git fetch --help

## Saving and uploading: the outward direction

We may visualize git actions as interaction between the working tree, the index, and the local and remote commit history. Thus, `add`, `commit`, and `push`, among others, transfer data from near to far. In this section, we study these “outward” instructions .

### Comparing

Before committing, it is helpful to see what new work has been done. To show modification not added to the index, that is, differences between working tree and the files as was indexed:

    $ git diff

If new work has been added to the index, you can still compare the files as was index with latest commit in the local repo,

    $ git diff --staged

Instead, to compare a specific file in the working tree with the committed version of it in the local repo, say `README.md`,

    $ git diff <commit_pointer> README.md

where `<commit_pointer>` is a pointer to the latest commit.

### Navigating `diff` result

After any of these, you will see a new page that summarizes modified lines, and what is changed.

Navigation commands are identical to `less`, and similar to Vim. Hit `j`, `e` or `^e` to forward one line (where `^` stands for Control key). Hit `k`, `y`, or `^y` to backward one line. Hit `f` or `^f` to forward one window. Hit `b` or `^b` to backward one window. Hit `d` or `^d` to forward one-half window. Hit `u` or `^u` to backward one-half window. Hit `q` or `:q` to quit. 

### Updating the index

If there are new files created or old files deleted, run this to update the index according to the present working tree:

    $ git add -A

The following does almost the same, except in that it ignores files in a newly created directory:

    $ git add .

### Committing

Before you commit, you may want to see a short summary of what files are changed and deleted, with

    $ git status

To commit, use `git commit`. However a commit message is strongly recommended, which reminds you as well as other people what you have done. For example,

    $ git commit -m "Rename files using new convention"

Summarize your work concisely, within less than some 70 characters. If you cannot do this, you should have probably split your work into two or more commits. It is the tradition that, to save space, verbs in base form are used, and no period is there in the end.

You can modify your commit message even after you commit, with

    $ git commit --amend

Now, an editor opens, showing the commit message in the beginning, where you may revise it. This file is saved as `.git/COMMIT_EDITMSG`.

I find it useful to edit here because you don't have to backslash-escape special characters, which may occur in verbatim expressions. You can also add more explanatory lines below, separated from the title with a blank line. The status is shown again as commented lines to recapitulate their difference for you.

### Viewing Commit Log

Afterwards, you can view the commit log with

    $ git log

The result shows commit IDs, authors, time stamps, and commit messages.

To make the log more concise and informative,

    $ git log --all --decorate --oneline --graph

The names of option are pretty explanatory. Mnemonic: "a dog".

### Identifying preceding commits

The pointer to current commit in question is `HEAD`. To retrieved its ancestors, two operators could be used. `HEAD^2` means going up two levels of node, pointing to the youngest of its grandparents of `HEAD`. `HEAD~2` means, within its several parents, counting twice the youngest elder siblings.
The two operators may be composed, for example `HEAD^3~2`.

### Pushing

To push all commits from the local repo to the master branch in the remote repo (`origin`) whenever they have not been updated,

    $ git push origin master

In the first time you push, you may want to create a "upstream tracking reference" to your remote repo by `-u`, so that, in the future when you push or pull, you do not need options by default.

    $ git push -u origin master

Say yes, if, the first time you push, you are asked that whether you should consider the RSA host key for GitHub's IP address as a safe one.

If you have messed up something, and Git is unable to figure out their ancestral relation and thus refuses to push, you may try with the flag `-f` or `--force`:

    $ git push origin master -f

This forces every commit in question in the local repo to overwrite its counterpart in the remote repo, and may cause the remote repo to lose data, so think twice before using it.

### Adding tags

To add a tag to the latest commit (even when you have modified the working tree after commiting), use

    $ git tag -a "v1.0" -m "Compile successful"

Replace the version number and tag message with yours; same for below.

To list simply all tag names,

    $ git tag

To see what (long) commit hash a tag points to, run

    $ git rev-list -1 "v1.0"

A `git push` don't automatically push a tag. You have to

    $ git push origin "v1.0"

## Updating or regressing the working tree: the inward direction

On the other hand, we now learn to transfer data from far to near, by `clone`, `fetch`, `checkout`, and `reset`, among others.

### Downloading from remote 

`clone`

`fetch`

### Creating or forking a new branch

A *branch* is a duplication of the working tree, so that the new branch based on it keeps being revised and developed afterwards. Thus, modifications happen in parallel, not only along the original branch, but the new one too. If the branch being based on is other people's work on GitHub for example, we also say it (the old branch) is being forked. To create a new branch `<name_of_new_branch>`, basing on the current working tree,

    git branch <name_of_new_branch>

### Shifting the head

But `branch` only does not change the head. To check out an existent branch `<another_branch>` already created with `git branch`,

    git checkout <another_branch>

In general, local files will be overwritten, making the working tree match <another_branch>. 

I suppose that, after modifying in the working tree, we had better commit them before checking out another branch, otherwise it is not obvious what will happen. If I make some change in (say) a test branch and, without committing, check out back the master branch, then the working tree will not restore to the state of the latest commit of master branch, and there will be no error message.

To make sure whether the head is pointed to the intended branch, use

    git branch

It will return a list of branches, with the current one highlighted (in my case colored green, and prefixed with a asterisk).

### Reversing the working tree

One way of reversing the working tree to a previous commit is `reset`, namely

    git reset HEAD^2 --hard

Alternatively, the option `--mixed` (which is the default option) only reverses the index and `HEAD` pointer, and `--soft` only reverses the `HEAD` pointer.

Beside `reset`, `revert` is another way to restore the working tree, but unlike `reset`, it creates a new commit. For example, with

    $ git revert <commit_pointer>

a new commit which is the previous commit being pointed, is now created. Note that the history is not rewritten in this case.

## Managing branches

In addition, we may also modify commit objects and the connection between them, changing the history and relation between branches.

### Merging branches

    git merge <merged_branch>

If there are conflicts, there will be an error message that tells you that. Git essentially overwrites the conflicting part of the file in the working tree. 

    <<<<<<<
    (The text excerpts according to the chief branch being merged into.)
    |||||||
    (The text excerpts according to the common ancestor version.)
    =======
    (The text excerpts according to the feature or development branch merging into the chief branch being considered.)
    >>>>>>>

The user is asked to replace lines between `<<<<<<<` and `>>>>>>>` (inclusive) with what he wants. After all conflicts are resolved, `add` the changes and merge again.

### Rewriting history

The command `rebase` applies respective changes of each commit from the current commit (where `HEAD` is) on the specified branch, by creating corresponding new commits.

    git rebase <branch_being_merged_into>

Alternatively, we may choose one commit of a certain branch only, and apply the change from the branching node up to itself, on the current commit. That is, doing the same as `rebase` only on certain commits, instead of all of them of that branch.

    git cherry-pick <commit_being_picked>

## More Information

* The Git [Documentation](https://git-scm.com/documentation)

    This is the documentation on the official homepage of Git. Same material may be found in `man` pages that are included in the Git package itself, to quote the site.

* Richard E. Silverman (2013). *Git Pocket Guide*. Sebastopol, CA: O’Reilly Media.

    Guides for Git are abundant. This is a readable short guide that may both be read from cover to cover, and looked up as reference.

* [Git—The Simple Guide](http://up1.github.io/git-guide/index.html)

    A table of for the most common Git commands, and very brief explanations for them. On the site, there is a downloadable PDF version.

* [Stack Overflow](http://stackoverflow.com)

    Stack Overflow is still the most likely place you end up with if you google your problem, but, since everyone can submit, you should take their advice with a grain of salt.

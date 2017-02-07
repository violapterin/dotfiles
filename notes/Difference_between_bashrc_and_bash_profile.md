# Difference between `.bashrc` and `.bash_profile`
*Jan. 19, 2017*

To understand when `.bash_profile` or `.bashrc` are used and differences between them, we introduce several terms. I shall focus on Mac OS, which I use. 

In an *interactive shell*, the user may type commands into it, execute them, and see their output on the screen. A *non-interactive shell*, in contrast, does not allow the user so. The moment one enters Mac's native `Terminal.app`, he or she is using an interactive shell. However, when he runs a shell script, a *non-interactive shell* is started that runs the script, and then exits when it finishes doing that. 

A *login shell* requires the user to type username and password to log in, but a *non-login shell* does not. (With definition above, they are interactive.) But `Terminal.app` automatically logs in when starting up, and thus is a login shell. Of course, the shell that is created by typing the command `login`, is too a login shell. And the examples of non-login shell include the new Bash instance the user invokes by typing `/bin/bash`, or another kind of shell, in a terminal.

In Mac, an interactive login shell reads `.bash_profile`, while an interactive non-login shell reads `.bashrc`. Default paths of `.bash_profile` and `.bashrc` are both the user's home. On the other hand, a non-interactive shell reads neither.

Actually there are `/etc/profile` (which Mac has created by default), `/etc/bash.bashrc`, `~/.bash_login`, `~/.profile`, `BASH_ENV`, and `~/.bash_logout`, all with subtlety due to historical reasons. But I am not going to figure them out. Instead, the most reliable solution is that the user shall put everything he sets into `~/.bashrc`, and make `~/.bash_profile` source `~/.bashrc`, as I did.



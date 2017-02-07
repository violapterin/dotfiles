# Remapping Input-Source-Switching Key
*Feb. 7, 2017*

Having discussed the problem of wrapping, I shall share several configurations and practices that, I find, make it easier to write prose with Vim.

The most used key in Vim, without doubt, is the Escape key, which returns to the normal mode.

And for a Chinese user, like me, the second most used function is also clear: switching input source (IS) between a Chinese-IS and English-IS. Thus the user is likely to find it cumbersome to switch mode in Vim in such need.

Indeed, to type one or more Chinese characters, he has to hit `i` (insert mode), switch to Chinese IS, type, switch back to English-IS, and hit escape. Such toil, unfortunately, nearly cancels the efficiency gained by Vim's modal design.

It seems best to set both Escape key and the IS-switching key (or key combination) to be something close to the home row (the resting positiong where `F` and `J` are). Though Sierra (by now the latest version of Mac OS) allows the user to toggle between two ISs by Caps Lock (see System Preferences > Keyboard > Input Sources), I have already mapped Caps Lock as Escape (which is also possible only as late as Sierra came out). See: System Preferences > Keyboard > Keyboard > Modifier keys). And even if I set Caps Lock as the switch, still I have to set another key near to the home row to be Escape, but Sierra only allows me to set either Shift, Option, or Command as Escape, and each possibility is impractical.

Fortunately, I found Karabiner Elements, which makes it possible to re-map keys. Karabiner Elements works by forcing the physical key `X`'s signal to be interpreted as key `Y`'s function. 

Its precursor is [Karabiner](https://pqrs.org/osx/karabiner/index.html.en), which has been out of order in Sierra. But the team produced a version called [Karabiner Elements](https://github.com/tekezo/Karabiner-Elements) for Sierra. Here is the [latest compiled image](https://pqrs.org/latest/karabiner-elements-latest.dmg). 

This is my setting. Physical Caps Lock now performs the function of Escape as before, and Escape that of `` `/~ ``, and `` `/~ `` that of Tab, and Tab that of F5 (or any seldom used function key; `F5` in Sierra dims the keyboard lighting), and `F5` that of Caps Lock.

Then I set `F5` to switch to the previously-used input source. I am proud of my setting. Vim users for non-Latin family language will save considerable effort with this!

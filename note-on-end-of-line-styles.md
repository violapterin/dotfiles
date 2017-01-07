# Note on end-of-line characters
*Jan. 7, 2017*

When editing, using Vim, a pure text file created by MS Windows, or copying and pasting, into Vim, some lines from a binary file created by MS Windows, one is likely to find the whole file, or part of it, shown with no proper end-of-lines (EOL, aka line break) as should have been, but instead strewn with `^M`'s. A `^M` is not concatenation of literal `^` and `M`, but a digraph. To type it, press `<c-v><c-m>` (`c` for control).

To removed them, type 

    :%s/\r/\r/g

I now explain why. Different operating systems save EOL as different Unicode characters. For MS DOS (like Windows) it is `<CR><LF>`, and for Unix and Mac `<LF>`, and for the very old Mac OS 9 just `<CR>`; here `<CR>`is the carriage return, and `<LF>` the line feed (aka `<NL>` the newline). Note that `<CR>` is not to be confused with `<cr>`, which stands for return key in my `.vimrc` in this repo.

I find that Vim renders a solitary `<LF>` as EOL (i.e. showing what follows on another line), but renders `<CR><LF>` as `^M` (the digraph meaning `<CR>`) only, while suppressing `<LF>`.

When being searched in Vim, `\r` represents `<CR>`, while `\n` represents EOL. But when being replaced in Vim, `\n` is used to represent `^@` the null character, so `\r` is used to represent EOL. In conclusion, to replace these superfluous `<CR>`'s with EOL's, just replace `\r` with `\r`.

For relevant information, see `:h fileformats`, `:h pattern`, and`:h digraph`, but throughout these help articles, different terminologies are used, making the whole affair confusing.


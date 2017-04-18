# Meaning of `.PHONY` in Makefiles
*Chinese version written Oct. 31, 2016* \
*English translated Jan. 31, 2017*

## Makefile Reviewed

GNU Make is a utility used to manage the building process, i.e., the linkage of compiled files. In it, a *target* is separated by a colon “`:`” from its *prerequisite*; this specifies a *dependency*. The left-hand-side target's last modified date is intended to be later than any of the right-hand-side prerequisite's last modified date. Otherwise, the *recipe* that follows the dependency declaration will be executed.

For example, I want to cook spaghetti with tomato sauce. If I have bought a new pack of spaghetti today, I shall cook the newly bought spaghetti, and shall not use the spaghetti I left last night in the refrigerator. This way, though the tomato sauce and minced meat need not be cooked again, but the totality of "spaghetti with tomato sauce" is thus newly cooked.

## The Keyword `.PHONY`

That said, if you have seen someone else's makefile, you would probably see the line

    .PHONY: clean

which is used to clean all the already compiled files. Note that the word `clean` has nothing special, but you have to specify its meaning, like:

    clean:
        rm -rf ./*.pdf

Why `.PHONY` is necessary? I have heard it from [a post](http://stackoverflow.com/questions/2145590/what-is-the-purpose-of-phony-in-a-makefile) on Stack Overflow that, while `clean` is not a real object, but an action, if there is a file named `clean` on the same directory (probably not a good idea to choose such name), than Make will not execute the recipe of `clean`, thinking it is up to date. But by declaring it phony, no longer does `clean`'s recipe depend on existence actual files, unlike genuine targets. Indeed, the literal meaning of "phony" is "fake".

But, while the example regarding phony targets given just above assumes that `clean` has no prerequistes, how is it like when `clean` does have one or more prerequisites? Indeed, now that a phony target does not even have last modified date (because it is not a file), it is not clear, then, when the recipe is executed, or if it is always executed.

## Some Experiments

### The First Test

Out of curiosity, I conducted a small experiment on `all`. Recall that `all` is executed when `make all` is run. Consider the makefile

    all: `f1` `f2`
    	@echo recipe \`\`all\'\' executed.
    `f1`:
    	@echo process 1:
    	touch `f1`
    `f2`:
    	@echo process 2:
    	touch `f2`
    clean:
    	rm `f1`
    	rm `f2`
    .PHONY: clean

When neither of `f1` nor `f2` exists, when I run `make`, the console output is, of course, 

    process 1:
    touch `f1`
    process 2:
    touch `f2`
    recipe ``all'' executed.

That is, both targets were generated. When I run `make` again, it is then

    make: `all' is up to date.

That is, recipe of `all` was not run.

### The Second Test

To reverse the situation to the beginning, run `make clean` which deletes both of `f1` and `f2`. Now, I generate an empty file by `touch all`. And I run `make`, and `f1` and `f2` will again be generated as above, and the console output is all the same as above. If `make` is run for a few more times, it says all is up to date as above.

This is because Make thought `all` remained to be generated again, for neither of `f1` nor `f2` exists.

### The Third Test

Again run `make clean` to delete `f1` and `f2`. This time, I run `make` first to generate them, and run `touch all` afterwards. Now run `make`, and notice the console outputs

    make: `all' is up to date.

Because the empty file `all` has shielded the target `all`, the recipe of `all` is not executed. Make thought I intended to make the file `all` in left-hand-side, which is later than right-hand-side, `f1` and `f2`. That is, here `all` is existent and up to date.

### The Fourth Test

Subsequently, I add this line in my makefile:

    .PHONY: all

and save the makefile. And I run `make` again. The console output is, instead,

    recipe ``all'' executed.

Indeed recipe of `all` is executed, as I thought. But `f1` and `f2` was not generated, as they already exists. Same happens when `make` is run for several more times. What a reassurance!

## Conclusion

In conclusion, as how I understand it, if a target has been declared as prerequisite of the `.PHONY` target, i.e. a target is phony, then its recipe will always be executed. Of course, when following the recipe, its own prerequisites must exist and up to date, as usual; if they are outdated, they will be generated in advance. In particular, if the phony target has no prerequisite, its recipe will be directly executed.

A phony target, in short, is thought of as something older than everything, as old as time. “File as old as time, true as it can be.”

# Towards a Plain-Text Oriented Workflow
*Feb. 2, 2017*

## Motivation: Need of Better Workflow

Recently I have recognized the dire need of devising a consistent way I save, supplement, and revise my work, especially as material had assimilated so much over the undergraduate years. They include notes or solved problems on science or mathematics classes or books, as well as all my non-technical, and, of course, coding projects for either scholastic purpose or for fun, and my music compositions so dear to me.

I have the intention that the toolkit I use will remain valid, or at least still compatible, for many years to come. Therefore I have carefully chosen the tools that have long lasted, widely used, actively maintained, and free. These tools are Bash, Git, Vim, Make, LaTeX, XeLaTeX, Markdown, LilyPond.

Before I describe them in detail, let me make the distinction between a *visual tool* and a *instructional tool*. Basically this overlap with the traditional division of WYSIWYG (what you see is what you get) and non-WYSIWYG tools. But I seek to convey a more subtle point than that, namely that a visual tool imitates the operation of physical objects in daily life, while an instructional tool simply commands the computer intended action.


Consequently plain-text formats are preferred to binary formats for numerous reasons:

* **Version control**. Indeed, it is painful to back things up to and fro across several USBs and guessing from last-modified date which is new. This is however easy with Git.

* **Concise storage**. Because bloat in the Doc/Docx format, initialization of Word is slow, and Word works while occupying a lot of system resource.

* **Easier command line manoeuvres**. Since plain text format is easy to access, command line tools exist that help conversion or manipulation of them.


# Plain Text and Version Control

It is no incidence that these best tools work in a lower level, and source they accept must be saved in plain text. I have elsewhere remarked this point, but the main idea is that only stripped of GUI, can the user communicate more directly with the shell, and afterwards call the power of modern computer, to compile, to control version, or even to automate all of these.

My task, then, is to find a way to save everything in plain text.
Starting from early 2014, I started to learn LaTeX.
My template is introduce in another note.

It becomes feasible to use Git as version control tool only after I decided to convert my pieces of prose to 

It is coincidental that I learn the existance of Markdown, a lightweight markup language. It is after I created account for Stack Exchange sites. When making answers or asking questions, I have no choice but learning Markdown. If only I had known that earlier! I then gradually corrected my past writings in order to be compilable as Markdown source. Before long I have written a Makefile so that my pieces of prose may be compiled with `pandoc`. Such procedure would be so much harder with the more verbose but powerful XeLaTeX.

To make it easier to convert Word documents to plain text files, Mac users may exploit the utility `textutil`. The usage is as thus:

    textutil -convert txt *.doc
    textutil -convert txt *.docx

The reader may modify the path to suit his or her need.

I also knew about LilyPond in August last year, which, to my joy, completes the last part of my workflow. It is hard to learn, but worth the effort, I deem. I decided to write a wrapper to simplify its verbose syntax, but that is a different story I will relate in another note.


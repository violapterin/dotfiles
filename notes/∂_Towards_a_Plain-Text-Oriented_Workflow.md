# Why Separating Form from Content
*Feb. 2, 2017*

## Concepts

I make the distinction between a *visual tool* and a *instructional tool*. Basically this overlap with the traditional division of WYSIWYG (what you see is what you get) and non-WYSIWYG tools. But I seek to convey a more subtle point than that, namely that a visual tool imitates the operation of physical objects in daily life, while an instructional tool simply commands the computer intended action.

A visual tool is more familiar to the user, but a instructional tool is more powerful and versatile. In general, apart from time spent leanring them, instructional tools save substantial time. They enable the user to communicate more directly with the computer, and thus is endowed with the full capacity of modern computer.

## Need of Better Workflow

Recently I have recognized the dire need of devising a consistent way I save, supplement, and revise my work, especially as material had assimilated so much over the undergraduate years. They include notes or solved problems on science or mathematics classes or books, as well as all my non-technical, and, of course, coding projects for either scholastic purpose or for fun, and my music compositions so dear to me.

I have the intention that the toolkit I use will remain valid, or at least still compatible, for many years to come. Therefore I have carefully chosen the tools that have long lasted, widely used, actively maintained, and free. These tools are Bash, Git, Vim, Make, LaTeX, XeLaTeX, Markdown, LilyPond.

Starting from early 2014, I started to learn LaTeX. I spent a lot of time to create a useful template, and it is introduced in another note. I am now fairly accustomed to type math in LaTeX.

On the other hand, it is coincidental that I learn the existance of Markdown, a lightweight markup language, when giving answers or asking questions on Stack Exchange sites. If only I had known that earlier! I then gradually corrected my past writings in order to be compilable as Markdown source.

I also knew about LilyPond in August last year, which, to my joy, completes the last part of my workflow. It is hard to learn, but worth the effort, I deem. I decided to write a wrapper to simplify its verbose syntax, but that is a different story I will relate in another note.

## TeX Formats vs. DOC/DOCX

TeX-family related formats (plain TeX, LaTeX, ConTeXt, and so on) prevails Word documents (DOC/DOCX) for numerous reasons. (Hereafter called respecitvely TeX files and Word files.)

### Version control

It is painful to back Word files up, to and fro across several USBs, guessing from last-modified date which one is newer. This is however easy with TeX files, because being saved in plain text, they are easily to be managed with Git!

### Concise storage

Word files are often bloated, since they are thickly wrapped with tags that specifies style, formatting and appearance. This is because the underlying markup format has to take care of every possible attribute. Moreover, DOC source is basically not human readable, and DOCX is likewise difficult or impossible to edit. Because a user cannot edit them, he or she cannot clean them up.

On the other hand, a TeX file is lightweight and succinct, because it only sketches what to be done when there is something to be done. And on top of that, the user may even enhance code reuse. 

### Transparency of source

A Word file is opaque, while a TeX file is simple and transparent.

The appreciation of simplicity of source is more deeply felt when the user is editing math formulae. Take for instance,

    \int_{-\infty}^{\infty} e^{-x^2} dx \cdot \int_{-\infty}^{\infty} e^{-y^2} dy 

In TeX, such syntax can never be ambiguous, if you are careful. When editing the same just quoted equation in Word, you are often unsure of what the "bolder" that separate objects. Consequently the second integration sign is easily kind-of "trapped" in the first integrand, in which case typesetting will be rendered wrong, and the user cannot just select and copy the first integration.

Transparency of source has another advantage that even though one day the relavent compilers are no more available, the user can still easily parse them automatically with modest effort, or at least convert them manually into a new viable format. If `pdflatex` were not to be released anymore, people can still have no difficulty understanding the meaning of source.But if Microsoft Word were abandoned by Microsoft—not likely in near future, but who knows—no Word document can be read by then. 

### Saving of system resources

The initialization of Word is slow, and Word works while occupying a lot of system resource.

But a TeX file can be opened by any editing environment, which displays the source passively and needs nearly no resource. Compilation is to be done only when appropriate, and the percentage of time it requires resources is scarce.

### Easier command line manoeuvres

Since plain text format is easy to access, command line tools exist that help conversion or manipulation of them. The user 

As a side remark, to convert Word documents to plain text files, Mac users may exploit the utility `textutil`. The usage is as thus:

    textutil -convert txt *.doc
    textutil -convert txt *.docx

The reader may modify the path to suit his or her need.

### Global namespace and package conflict

However, there is one serious disadvantage of LaTeX or ConTeXt, which is absent in Word. The abstraction of LaTeX is not complete either, and the package often conflicts.

We recall that a CPU is essentially a Turing machine, and the concept of state is inherent in its design. This result an expression-oriented programs (EOP). It is well known that every EOP can be rewritten into a function-oriented program (FOP). Being easier to maintain, FOP is usually favored to EOP. But while EOP is too complicated, object-oriented programming (OOP) is a compromise of they two. OOP allows state variables, but limit their scope within the object.

I don't know whether it is just to say such, but it seems to me that a TeX-family program is closer to the older style of expresssion-oriented programs, and the side effect is prominent. Indeed, conflict mostly results from redefinition of variables with `let`. Such thing will happen as long as a package is merely a *macro* instead of a proper *function*.

Meanwhile, a Word document seems more an objected-oriented program to me: words, tables, and graphics are all objects with attributes. Whether they conflict or not is maintained by Microsoft, but seemingly there is no serious bug.

The moral is that, when the user is insulated from some operation and these features are provided through interface, apart from whether it is successful, the interface must be consistent. If those provided features conflict each other, there is no way to remedy.




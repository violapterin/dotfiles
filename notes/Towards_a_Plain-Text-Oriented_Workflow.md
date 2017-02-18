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

We start our investigation by taking a look at one of the most well known product in the modern everyday life—the Microsoft Word (hereafter Word). Word is so ubiquitous, that people seldom question its very existence. There is nothing wrong with it, since necessities in an average modern life are far more complicated then anyone can know well throughout 

But, in fact, what Word deals with is source code, as any computer program does. Word displays DOC on the computer screen in a manner that resembles the appearance the document is to be printed on paper. User then drag, click, select, or type on the interface Word supplies, and Word maps the action to underlying modification of source code. This is kind of (harmless) deception.

Nevertheless, arguably every abstraction, unfortunately, is leaky. While we may still, of course, be satisfy with this, and work in the abstracted layer. Even though most people have seen the limitation of Word, but tolerate for years, even though they don't have to. The inconvenient fact is that for most need, Word is just not powerful nor efficient enough.

And TeX-family related formats (plain TeX, LaTeX, ConTeXt, and so on) prevails Word documents (DOC/DOCX) for numerous reasons. (Hereafter called respecitvely TeX files and Word files.)

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

## LilyPond format vs. Sibelius and Finale format

Just like the case for TeX, LilyPond's format, which has extension `.ly` (hereafter called LY source), is saved in plain text, while like Microsoft Word, Sibelius (`.sib`) and Finale (`.musc`) use proprietary, opaque formats. So the comparison between Doc and Tex formats mostly apply here.

### Advantage of splitting sources

For example, lyrics are easier to edit in the plain text. In Sibelius the addition or deletion of lyrics means re-typing the whole line, but in LilyPond no more than editing modified part.

Editing orchestral score and parts is cumbersome in Sibelius when the file gets large, but LilyPond makes it possible to focus on one or two instruments only by commenting out others and just including the relevant parts, like how it is when writing codes. When it is done, just putting them together.

As mentioned in the previous section on TeX vs. DOC/DOCX, more serious is the problem of back-compatibility and persistence of formats of music score. The worry of obsolete formats is real enough. In fact, Sibelius is somewhat abandoned by Avid company, and the future of Sibelius is unknown, though a new product, Dorico, by the original team was recently released. If it disappears, all old SIB scores are not easily modified. On the contrary, since LY source is transparent, well-documented, it will be easy to convert or modify at all times, and no information will be lost.

### Inconvenience for lack of GUI

On the other hand, composing, as well as fine-tuning score layout, nevertheless has more component of graphical nature than writing text. Take Sibelius for instance, which I am familiar. Both Sibelius and LilyPond implement a slur as a Bézier curve, which is determined by four points on the plane that span a trapezoid. It is easy in Sibelius to draw a slur, since the eye-hand coordination helps the user to control its curvature. But is not easy to directly estimate the proper location of four points in the head, then specify them in the LY source. 

There are some other things you can do conveniently in Sibelius and Finale, but not in LilyPond, like: directly, with one keystroke combination, deleting measure 7 in all staves; or transposing the source from measures 11 to 15 of both violins and cellos only by a minor third; or giving each of these selected notes a staccato, and so on.

### Navigation

Moreover, when still assembling my material, my source is a chaos, and I deem it not easy to find the line where a particular passage of mine is among my LY source. A GUI Frescobaldi exists, that offers a split view of both source and compiled PDF, like TeXstudio. Even so, locating the source is still not easy. Indeed, in TeXstudio, `synctex` provides the map between source and PDF, but there is no comparable utility designed for LY source.

Navigation might be easier, if the composer comments its measure number on every measure, or every five measure for example. But that is not feasible, since numbers will change as I reorganize or add material.

But also arguably, navigation a plain-text LY source back and forth is way easier compared with corresponding actions in Sibelius or Finale, in which case mouse-dragging is necessary and display can be slow. The point is comparable in the TeX vs. DOC/DOCX case.

## Vim vs. TextEdit and Notepad

The Last example is the comparison between Vim and TextEdit (or Notepad). Microsoft Word is also relevant here, though the comparison is complicated by the Doc format, which is treated above. It is perhaps surprising to digress from debates on typesetting format for text and music to one on text editors. But a moment's revelation, as follows, shows that underlying concerns are similar.

### Introduction of modes

Most text editors mimic the everyday life action on objects. 
Indeed, when we type, we pretend we are using a typewriter, and when we delete, the delete key resembles kind of eraser that scrape ink away. 
When we select some words, we drag the cursor over them, like we are painting.

For ease of imagination, each keys are imparted with a fixed meaning. Only a few so-called "modifier keys" can be used in combination with others, for sake of change their actions. This lowers the required training, making laypeople more easily to be familiar with the product.

Vim, on the other hand, simply instructs necessary navigation or editing actions. Not imitating a typewriter-using experience opens up a whole range of possibility. A very creative solution to the navigation problem was thus possible, namely the concept of *mode*. We have mainly the normal mode, insert mode, and visual mode. Our keyboard essentially plays three times of original roles. This replaces the job of mouse, and complicated key combinations are no longer necessary either.

The existence of modes incompatible with the principle of visual resemblance, since after all physical objects don't possess multiple modes. When I write with ink on paper, I cannot press a button so that the pen temporarily act as an eraser or something else.

But introduction of modes has the advantage of directness. To flip 3 pages, just scroll as long as the distance that amounts to 3 pages. The scroll is established through a translation of mouse (or trackpad) motion to display area. Meanwhile, it is less straightforward to specify that "I want to scroll 3 pages", by hitting `3<ctrl>F`. Thus 3 pages slide away briskly, but the feeling of actually scroll something is lost.

### Other virtues of Vim

Vim has many other virtues, like recording, repeating, regex, remapping, and Vimscript. So you get my point. It is fair to say that Vim is generous to let the user play with the fundamental instructions of the user-to-application interaction, which is only possible with no obstruction of GUI.

Such openness and flexibility is precious for senior users, but it also makes some people uneasy. The sense of uneasiness, I say, is due to the lost of connection with everyday life, for the dream that he or she is controlling something physical is shattered.

## Having a Good Tool matters

Put another way, I have come to appreciate the dilemma that some of the more counter-intuitive tools, by which you cannot see what you get, are actually superior. Yes, instructional tools are superior than visual tools in most cases. In other words, the more simple a tool is to use for rudimentary goals, the more cumbersome it is for more sophisticated goals. The trade-off is, in general, inevitable to a certain extent. 

I am not against those using Word for whatever purpose. But, as I see, many too have the need for a better tool for their jobs, no matter they are preparing a proposal, writing reports, or sketching an original novel. But the truth is, most people need a better tool for their jobs, but they are unwilling to switch purely due to prejudice and (or) laziness.

Instead of explain over and over to friends of mine why I use LaTeX, LilyPond, and Vim, I thus decide to summarize in this note for geeks, like me, who want to persuade other people the same thing. O, truly I say unto you, when you see something nerds recommend, try it out earnestly before you declare it does not suit you, for you may actually like it and be unable to live without it.



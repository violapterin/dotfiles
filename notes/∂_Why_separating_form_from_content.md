# Why Separating Form from Content
*Jan. 22, 2017*

# Overview

$After so many times I explain to friends why I use LaTeX, I decide to prepare a cheat sheet for geeks, like me, who want to persuade other people to use LaTeX, or indeed other *tools that separates form from content*.

$Put another way, I have come to appreciate the dilemma that some of the more counter-intuitive tools, by which you cannot see what you get, are actually superior. In other words, the more simple a tool is to use for rudimentary goals, the more cumbersome it is for more sophisticated goals. The trade-off is, in general, inevitable to a certain extent. 

$I shall shortly elaborate this point, and provide three examples. LaTeX will be my major example, and afterwards I shall briefly discuss LilyPond, and Vim, having similar nature and reaction as LaTeX. I make no claim that my insights are original; they have been pointed out endlessly in official websites or in related forums for the program in question. Nevertheless, I have stressed what I particularly agree in my personal experience.

# A Network Model of the Writing Process

We start our investigation by taking a look at one of the most well known product in the modern everyday life—the Microsoft Word (hereafter Word).
Word is so ubiquitous, that people seldom question its very existence.
People take for granted the way Word processes text, hardly aware that there is even other alternatives.

But what Word deals with is source code, as any computer program does, in this case the DOC format.
Word displays DOC on the computer screen in a manner that resembles the appearance the document is to be printed on paper.
User then drag, click, select, or type on the interface Word supplies.
Word maps the action to underlying modification of source code.

Display —— Source —— Machine code —— Compilation —— Product

Thought —— Edit —— 

With this understood, we can perhaps phrase the concept *separation of form from content* as thus.
Without such separation, the user edit on an interface that 
Such separation 


From here we conclude several 

# Leaky abstraction

Now comes the revelation that necessities in an average modern life are far more complicated then anyone can know well throughout 
Every abstraction, unfortunately, is leaky.
We may still, of course, be satisfy with this, and work in the abstracted layer
[cite...]

And I say that well does most people know the limitation of Word, but tolerate for years, even though they don't have to.
The inconvenient fact is that for most need, Word is just not powerful nor efficient enough.

# LaTeX vs. DOC/DOCX

Each point may well be elaborated at length, but I will strive to be concise.

* Size of file. 

It should be remarked that their respective file size also differ greatly, and that DOC source is basically not human readable, and DOCX is likewise difficult or impossible to edit. But the reason behind does not completely line with my criticism against WYSIWYG.

Indeed, a DOC file is much larger than a similarly handled LaTeX file, since it is thickly wrapped with tags that specifies style, formatting and appearance. The underlying markup language, XML, 
But to be fair, it is more a fault of Microsoft, than a drawback of WYSIWYG itself.

I don't think we cannot have the best of both worlds of WYSIWYG and source code.
Word can choose a less verbose language for source, and editor can improve too.

    In contrary, a TeX file is lightweight and succinct, because it only sketches what to be done, rather than specifying its visual details. A 

It was furthermore said that `.doc` file's source was deliberately obfuscated, accounting that fact that it is so much boated. 

* **Version control**. It is crucial to be able to compare several versions of a project in a concise way. In LaTeX, comparison is trivial with utility like `diff`. But in DOC, 

* Navigation and selection. 

* Transparence of source.
Editing equation: you are not sure what box is
Font: even though style sheet can be used, it is still not evident that 

* 

And, the concern that MS had and will dominate software market, is also real enough. I heard that a competitor, Word Perfect, was better than MS Word even as late as early 2000s, yet MS won the market. Why? MS buy all competitors and always change to an incompatible format. 



# LilyPond format vs. Sibelius and Finale format

Just like the case for TeX, LilyPond's format, which has extension `.ly` (hereafter called LY source), is saved in pure text, while like Microsoft Word, Sibelius (`.sib`) and Finale (`.musc`) use proprietary, opaque formats. So the comparison between Doc and Tex formats mostly apply here.

For example, lyrics are easier to edit in the plain text. In Sibelius the addition or deletion of lyrics means re-typing the whole line, but in LilyPond no more than editing modified part.

Editing orchestral score and parts is cumbersome in Sibelius when the file gets large, but LilyPond makes it possible to focus on one or two instruments only by commenting out others, like how it is when writing codes. When it is done, just putting them together.

!!!!
The worry of obselete format is alleviated by the introduction of LilyPond. Indeed, Sibelius is somewhat abandoned by Avid company, and the future of Sibelius is unknown. If it disappears, all old scores are not easily modified. 
By LY source is transparent and easy to convert or modify. since elost information

On the other hand, composing, as well as fine-tuning score layout, nevertheless has more component of graphical nature than writing text. Take Sibelius for instance, which I am familiar. Both Sibelius and LilyPond implement a slur as a Bézier curve, which is determined by four points on the plane that span a trapezoid. It is easy in Sibelius to draw a slur, since the eye-hand coordination helps the user to control its curvature. But is not easy to directly estimate the proper location of four points in the head, then specify them in the LY source. 

Moreover, when still assembling my material, my source is a chaos, and I deem it not easy to find the line where a particular passage of mine is among my LY source. A GUI Frescobaldi exists, that offers a split view of both source and compiled PDF, like TeXstudio. Even so, locating the source is still not easy. Indeed, in TeXstudio, `synctex` provides the map between source and PDF, but there is no comparable utility designed for LY source.

Navigation might be easier, if the composer comments its measure number on every measure, or every five measure for exampel. But that is not feasible, since numbers will change as I reorganize or add material.

There are some things you can do conveniently in Sibelius and Finale, but not in LilyPond, like: directly, with one keystroke combination, deleting measure 7 in all staves; or transposing the source from measures 11 to 15 of both violins and cellos only by a minor third; or giving each of these selected notes a staccato, and so on.

# Vim vs. TextEdit and Notepad

The Last example is the comparison between Vim and TextEdit (or Notepad). Microsoft Word is also relevant here, though the comparison is complicated by the Doc format, which is treated above.

It is perhaps surprising to digress from debates on typesetting format for text and music to one on text editors. But a moment's revelation, as follows, shows that underlying concerns are similar.

Most text editors mimic the everyday life action on objects. 
Indeed, when we type, we are 
When we select some words, we drag the cursor over them, like we are painting.

This lowers the required training, making laypeople more easily to be familiar with the product.

The 

Vim, on the other hand, simply instucts necessary navigation or editing actions. The alphabet keys in most text editors 



Not doing so opens up a whole range of possibility. A very creative solution to the navigation problem was thus possible, namely the concept of mode, which is incompatible with the visual principle. We have mainly the normal mode, insert mode, and visual mode. Our keyboard essentially plays three times of original roles. This replaces the job of mouse, and complicated key combinations are no longer necessary either.

It is less straightforward to specify that "I want to scroll 3 pages", rather than scroll so long that the distance amouts to 3 pages.
The latter is through a translation of mouse (or trackpad) motion to display area.

Vim has many other virtues, like recording, 
The decision of not implementing these features in 

# Having a Good Tool matters

I am not against those using Word for whatever purpose. 
But, as I see, many too have the need for a better tool for their jobs, no matter they are preparing purposals, writing reports, 


--------------------------

Word processing documents is said to be saved in a WYSIWYG format. 
Otherwise, or a plain text format 
(Indeed, such possibility is strange that a source, when being edited, is rendered in some way that does not resemble its final intended looking, yet the user cannot edit the source as plain text either. I cannot think of a instance of it.)

The superiority of plain text is that it is 
They are simple to navigate, 
does not require additional software to display


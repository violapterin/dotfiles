
# Overview

$After so many times I explain to friends why I use LaTeX, I decide to prepare a cheat sheet for geeks, like me, who want to persuade other people to use LaTeX, or indeed other *tools that separates form from content*.

$Put another way, I have come to appreciate the dilemma that some of the more counter-intuitive tools, by which you cannot see what you get, are actually superior. In other words, the more simple a tool is to use for rudimentary goals, the more cumbersome it is for more sophisticated goals. The trade-off is, in general, inevitable to a certain extent. 

$I shall shortly elaborate this point, and provide three examples. LaTeX will be my major example, and afterwards I shall briefly discuss LilyPond, and Vim, having similar nature and reaction as LaTeX. I make no claim that my insights are original; they have been pointed out endlessly in official websites or in related forums for the program in question. Nevertheless, I have stressed what I particularly agree in my personal experience.

# A Network Model of the Writing Process

We start our investigation by taking a look at one of the most well known product in the modern everyday life—the Microsoft Word (hereafter Word). Word is so ubiquitous, that people seldom question its very existence. There is nothing wrong with it, since necessities in an average modern life are far more complicated then anyone can know well throughout 

But, in fact, what Word deals with is source code, as any computer program does. Word displays DOC on the computer screen in a manner that resembles the appearance the document is to be printed on paper. User then drag, click, select, or type on the interface Word supplies, and Word maps the action to underlying modification of source code. This is kind of (harmless) deception.

Nevertheless, argurably every abstraction, unfortunately, is leaky. While we may still, of course, be satisfy with this, and work in the abstracted layer. 

Even though most people have seen the limitation of Word, but tolerate for years, even though they don't have to. The inconvenient fact is that for most need, Word is just not powerful nor efficient enough.


And, the concern that MS had and will dominate software market, is also real enough. I heard that a competitor, Word Perfect, was better than MS Word even as late as early 2000s, yet MS won the market. Why? MS buy all competitors and always change to an incompatible format. 



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

I am not against those using Word for whatever purpose. But, as I see, many too have the need for a better tool for their jobs, no matter they are preparing a proposal, writing reports, or sketching an original novel. But the truth is, most people need a better tool for their jobs, but they are unwilling to switch purely due to prejudice and (or) laziness.

O, truly I say unto you, when you see something nerds recommend, try it out earnestly before you declare it does not suit you, for you may actually like it and be unable to live without it.

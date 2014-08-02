
# Introduction

ad2play is Ruby script which converts
files written in asciidoc markup 
to Swift playgrounds. To use ad2play,
type

`$ ./ad2play foo.ad`

or 

`$ ruby ad2play foo.ad`

This will produce a Swift playground  named foo.playgound from the source  file foo.ad

# Installation

1. Make sure that Ruby v 2.1.1 or greater is installed.  

2. Install asciidoctor if necessary:

   `$ gem install asciidoctor` 

    See [asciidoctor.org](http://asciidoctor.org). 

3. `$ git clone http://github.com/jxxcarlson/ad2play`

4. Now `cd` into the folder `ad2play` that you just created.  Type `./ad2play basic.ad` to run one of the examples. If `ad2play` runs, your installation is complete and correct. You should see the following
 
```
$ ./ad2play basic.ad

  Writing playground ...
  section-0.html
  section-1.swift
  section-2.html
  section-3.swift
  section-4.html
```

 
5. If you do not see the above output, check the fullowing:
  - Is `ad2play` executable?
  - Is ruby v 2.1.1 or greater installed?
  - Is `asciidoctor` installed?

For now, you need to work in the root of the cloned  directory, ad2play.  
It contains the file asciidoctor.css which is needed for manufacturing
the playgrounds.


# Experimentation

1. Once installation is complete, open 
the directory ad2play in the finder.
Double-click on foo.playground.
It should open in XCode.  Experiment
with it -- you can change the Swift
code in the playground.  Then double
click on the other .playground files.

2. Run the command

$ ./ad2play foo.ad

If it runs, your installation is working.
If it does not, check permissions.
Now modify foo.ad and run ad2play again.


3. Write your own .ad files and compile
them as ordinary html files or as 
.ad documents.  Experiment with
*ad2play* and *ad2html*.

# Mathematics

In-line mathematical text is written like this:
`\(a^2 + b^2 = c^2\)` (LaTeX). Displayed mathematical
text is written like this:
```
\[
    a^2 + b^2 = c^2
\]
```

# Comments

`ad2play` used [Asciidoctor](http://asciidoctor.org) to 
convert the markup into the bundle of files
that make up a Swift playground.

The advantage of writing in asciidoc is that 
the same file can be used to publish in
different "media". If you have content
you wish to publish that resides in `foo.ad`
run the command `asciidoctor foo.ad`
to produce `foo.html`.  Run
the command  `./ad2play foo.ad`
to produce the Swift playground bundle
`foo.playground`.  If `foo.ad` contains
mathematical text formatted as described
above, use `./ad2html`.  This little
script runs `asciidoctor` and then does
a little postprocessing.

I would like to credit *jas*
whose [playground-builder](http://github.com/jas/swift-playground-builder)
inspired me to write `ad2play` so as to work with asciidoc.  

Current version of `ad2play`: 0.1 (hacked together).

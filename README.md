
# Introduction

**`ad2play`** is Ruby script which converts
files written in asciidoc markup 
to Swift playgrounds. To use ad2play,
type

`$ ./ad2play foo.ad`

or 

`$ ruby ad2play foo.ad`

This will produce a Swift playground named `foo.playgound` from the source  file `foo.ad`.

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

## Troubleshooting

If you do not see the above output, check the fullowing:
- Is `ad2play` executable?
- Is ruby v 2.1.1 or greater installed?
- Is `asciidoctor` installed?

## Notes

For now, you need to work in the root of the cloned  directory, ad2play.  
It contains the file asciidoctor.css which is needed for manufacturing
the playgrounds.

You are now ready to write your own `.ad` files and compile
them as playgrounds using `ad2play` -- or as  html files using `asciidoctor`.

# Mathematics

In-line mathematical text is written like this:
`\(a^2 + b^2 = c^2\)` (LaTeX). Displayed mathematical
text is written like this:
```
\[
    a^2 + b^2 = c^2
\]
```

When your asciidoc file contains 
mathematical text formatted as described
above, use `./ad2html` to produce html files.  
This script runs `asciidoctor` and then does
a little postprocessing.

# Comments

`ad2play` uses [Asciidoctor](http://asciidoctor.org) to 
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
`foo.playground`.  

I would like to credit *jas*
whose [playground-builder](http://github.com/jas/swift-playground-builder)
inspired me to write `ad2play` so as to work with asciidoc.  

Current version of `ad2play`: 0.1 (hacked together).

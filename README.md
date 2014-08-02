
# Introduction

**`ad2play`** is Ruby script which converts
files written in asciidoc markup 
to Swift playgrounds. To use **`ad2play`**,
type **`./ad2play foo.ad`** or **`ruby ad2play foo.ad`**
at the command line.  This will produce a Swift playground 
named **`foo.playgound`**.
You can double-click on **`foo.playground`** to open it in XCode. 

Swift code should be set off from the rest of the text like this:

```
[source, swift]
--
let pi = 3.1416
var r = 2.718
var a = pi*r*r
--
```

To create an html version
of **`foo.ad`**, run **`asciidoctor foo.ad`** at the command line.  

# Installation

1. Make sure that Ruby v 2.1.1 or greater is installed.  

2. Install asciidoctor:

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

**Note.** For now, you need to work in the root of the cloned  directory, `ad2play`.  
It contains the file `asciidoctor.css` which is required for manufacturing
the playgrounds.

# Troubleshooting

If you do not see the above output, check the following:
- Is `ad2play` executable?
- Is ruby v 2.1.1 or greater installed?
- Is `asciidoctor` installed?


# Images

**`ad2play** creates a directory `images` in `foo.playground/Documents`.  
This is where you put images that you wish to display in your playground.
(See `drawing101.playground` for an example.) 

To display the image `bar.png` in the playground `foo.playground`, 
copy it  into
`foo.playground/Documents/images`.  In the source file, `foo.ad`,
add the text `image::bar.png[width=200]`.  

**Variants:**
- `image::bar.png[]`
- `image::bar.png[width=200]`
- `image::bar.png[float=left, width=200]`
See the documentation at [asciidoctor.org](http://asciidoctor.org)
for more information.

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

The advantage of writing in asciidoc is that 
the same file can be used to publish in
different "media". If you have content that
 resides in `foo.ad`,
run the command `asciidoctor foo.ad`
to produce `foo.html`.  Run
the command  `./ad2play foo.ad`
to produce the Swift playground bundle
`foo.playground`. 

**Note.** [Asciidoctor Live Preview](http://chrome.google.com/webstore/detail/asciidoctorjs-live-previe/iaalpfgpbocpdfblpnhhgllgbdbchmia)
is a plugin for the Chrome browser that gives a live preview of asciidoc text you are writing.  Install,
configure, and then open `foo.ad` with Chrome.  Asciidoctor Live Preview is written by Guillaume Grossetie, source code is at
[GitHub](https://github.com/asciidoctor/asciidoctor-chrome-extension).

**Credit.** `ad2play` uses [Asciidoctor](http://asciidoctor.org) to 
convert the markup into the bundle of files
that make up a Swift playground.  

**Credit.** Thanks to *jas*.
His [playground-builder](http://github.com/jas/swift-playground-builder),
which creates playgrounds from markdown files,
inspired me to write `ad2play` so as to work with asciidoc.  

Current version of `ad2play`: 0.1 (hacked together).

**Copyright** :copyright: 2014 James Carlson. Free use of this software is granted under the terms of the MIT License

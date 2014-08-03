import Cocoa; import XCPlayground // Set Xcode to MacOS, not IOS

let graphWidth: CGFloat = 300.0; let graphHeight: CGFloat = 300.0

var frameRect = NSRect(x: 0, y: 0, width: graphWidth, height: graphHeight)
var view = NSImageView(frame: frameRect)

var size = NSMakeSize( graphWidth, graphHeight )
var image = NSImage(size: size)

image.lockFocus()

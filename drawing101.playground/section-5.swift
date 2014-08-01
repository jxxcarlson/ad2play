let foregroundColor = NSColor.blackColor()
 foregroundColor.setFill()
 
let dim: CGFloat = 40.0
 
NSRectFill(NSMakeRect(0, 0, dim, dim))
 NSRectFill(NSMakeRect(graphWidth - dim , graphHeight - dim, dim, dim))
 
image.unlockFocus()
 
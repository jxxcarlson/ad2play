image.lockFocus()

var path = NSBezierPath()

path.moveToPoint(NSPoint(x: 0, y: 0))

path.lineToPoint(NSPoint(x: graphWidth, y: graphHeight))

path.stroke()

image.unlockFocus()

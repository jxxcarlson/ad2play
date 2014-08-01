shift = 0
 
while shift <= 300 {
         
        image.lockFocus()
         var path = NSBezierPath()
         path.moveToPoint(NSPoint(x: shift, y: 0))
         path.lineToPoint(NSPoint(x: graphWidth, y: shift))
         path.stroke()
         shift = shift + 14
         image.unlockFocus()
         
}
 
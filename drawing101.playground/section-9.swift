var shift: CGFloat = 0.0
 let increment: CGFloat = 14.0
 
while shift <= 300 {
         
        image.lockFocus()
         var path = NSBezierPath()
         path.moveToPoint(NSPoint(x: shift, y: graphHeight))
         path.lineToPoint(NSPoint(x: 0, y: shift))
         path.stroke()
         shift = shift + 14
         image.unlockFocus()
       
}
 
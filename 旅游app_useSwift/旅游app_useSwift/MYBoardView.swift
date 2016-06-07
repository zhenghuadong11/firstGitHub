//
//  MYBoardView.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/30.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYBoardView: UIView {

    var points:Array<Array<CGPoint>> = Array<Array<CGPoint>>()
    var currentPoints:Array<CGPoint> = Array<CGPoint>()
    var colors:Array<UIColor> = Array<UIColor>()
    
    var currentColor:UIColor = UIColor.blackColor()
    
    var lineSizes:Array<CGFloat> = Array<CGFloat>()
    var currentLineSize:CGFloat = 1
    
    var imageViews = Array<MYDrawImageView>()
    var indexs = Array<Int>()
    
    var colorType = 1
    var clipType = false
    var clipGrayView = UIView()
    var clipStartPoint:CGPoint?
    var clipEndPoint:CGPoint?
    
    
    
    func addImageView(imageView:MYDrawImageView) -> Void {
              imageViews.append(imageView)
              indexs.append(2)
    }
    
    func decidePosition() -> Void {

        for var view in self.subviews
        {
            if view.isKindOfClass(MYDrawImageView)
            {
               self.addImageView(view as! MYDrawImageView)
               
            }
        }
     
        for var view in self.subviews
        {
           if view.isKindOfClass(MYDrawImageView)
           {
               view.removeFromSuperview()
            }
        }
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        var imageIndex = 0
        var lineIndex = 0
        
        for var i1 in 0..<indexs.count
        {
           if indexs[i1] == 1
           {
            var tmpPoints = points[lineIndex]
            
            let path = UIBezierPath.init()
            
            colors[lineIndex].setStroke()
           
            path.lineWidth = lineSizes[lineIndex]
            path.moveToPoint(tmpPoints.first!)
            
            if tmpPoints.count <= 1
            {
                continue
            }
            for var i2 in 1..<tmpPoints.count {
                path.addLineToPoint(tmpPoints[i2])
              }
              path.stroke()
             lineIndex += 1
           }
           else
           {
              let imageView = self.imageViews[imageIndex]
               if imageView.image != nil
               {
                imageView.image!.drawInRect(imageView.frame)
               }
               imageIndex += 1
            }
            
        }
        
        let path = UIBezierPath.init()
        if self.currentPoints.count == 0
        {
           return
        }
        
        path.moveToPoint(self.currentPoints.first!)
        if self.currentPoints.count <= 1
        {
            return
        }
        self.currentColor.setStroke()
        path.lineWidth = self.currentLineSize
        for var i1 in 1..<self.currentPoints.count {
            path.addLineToPoint(self.currentPoints[i1])
        }
       path.stroke()

      
       
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
            let touch = (touches as NSSet).anyObject()
            if clipType == true
            {
             self.clipStartPoint = touch?.locationInView(self)
             
            }
            else
            {
            self.currentPoints.append((touch?.locationInView(self))!)
            }
        
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
            let touch = (touches as NSSet).anyObject()
            if self.clipType == true
            {
                self.clipEndPoint = touch?.locationInView(self)
                self.clipGrayView.hidden = false
                let x = min(self.clipStartPoint!.x, b: self.clipEndPoint!.x)
                let y = min(self.clipStartPoint!.y, b: self.clipEndPoint!.y)
                let width = abs(self.clipEndPoint!.x-self.clipStartPoint!.x)
                let height = abs(self.clipEndPoint!.y-self.clipStartPoint!.y)
                
               self.clipGrayView.frame = CGRectMake(x, y, width, height)
             
            }
            else
            {
            self.currentPoints.append((touch?.locationInView(self))!)
            self.setNeedsDisplay()
            }
    }
    func min(a:CGFloat,b:CGFloat) -> CGFloat {
          if a>b
          {
             return b
          }
        return a
    }
    func abs(a:CGFloat) -> CGFloat {
         if a<0
         {
             return -1*a
         }
        return a
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
           if self.clipType == true
           {
            
               let clipImageView = MYDrawImageView()
               clipImageView.userInteractionEnabled = true
               clipImageView.frame = self.clipGrayView.frame

               self.addSubview(clipImageView)
               self.clipGrayView.hidden = true

               UIGraphicsBeginImageContextWithOptions(self.frame.size, true, 0)
            
               self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
            
            
               let bigImage = UIGraphicsGetImageFromCurrentImageContext()
               UIGraphicsEndImageContext()
           
               let bigImageRef = bigImage.CGImage
               let subImageRef = CGImageCreateWithImageInRect(bigImageRef,clipImageView.frame)
               UIGraphicsBeginImageContext(clipImageView.frame.size)
               let context = UIGraphicsGetCurrentContext()
               CGContextDrawImage(context, clipImageView.frame, subImageRef)
            
            
            
            
               let subImage = UIImage.init(CGImage: subImageRef!)
               UIGraphicsEndImageContext()
               clipImageView.image = subImage
            
           }
            else
           {
            let touch = (touches as NSSet).anyObject()
            self.currentPoints.append((touch?.locationInView(self))!)
            points.append(currentPoints)
            colors.append(currentColor)
            indexs.append(1)
            self.lineSizes.append(self.currentLineSize)
            currentPoints = Array<CGPoint>()
           }
    }
    
    override func didMoveToSuperview() {
        self.addSubview(self.clipGrayView)
        self.clipGrayView.backgroundColor = UIColor.grayColor()
        self.clipGrayView.alpha = 0.3
    }
    
}

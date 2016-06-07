//
//  MYDrawImageView.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/5/1.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYDrawImageView: UIImageView  {

    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
          
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
     
              let touch = (touches as NSSet).allObjects.first as! UITouch
              let currentPoint = touch.locationInView(self)
              let prePoint = touch.previousLocationInView(self)
              let x = currentPoint.x - prePoint.x
              let y = currentPoint.y - prePoint.y
              self.frame.origin.x += x
              self.frame.origin.y += y
    }
    

}

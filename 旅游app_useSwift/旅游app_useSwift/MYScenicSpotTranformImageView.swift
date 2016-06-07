//
//  MYScenicSpotTranformImageView.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/5/3.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYScenicSpotTranformImageView: UIImageView {
  
    var index:Int = 1
    var imageNames:Array<String>{
        set{
              self.userInteractionEnabled = true
              self.imageNamesTmp = newValue
              self.image = UIImage.init(named: imageNames[0])
            
         }
        get{
              return self.imageNamesTmp!
        }
    
    }
    var imageNamesTmp:Array<String>?
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        if index == self.imageNames.count
        {
            index = 0
        }
        
        self.image = UIImage.init(named: self.imageNames[index])
        
        index += 1
        
        let anim = CATransition.init()
        anim.type = "pageCurl"
        anim.duration = 1
        self.layer .addAnimation(anim, forKey: nil)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

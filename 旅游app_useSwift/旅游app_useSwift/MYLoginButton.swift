//
//  MYLoginButton.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/30.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYLoginButton: UIButton {

 
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
            let path = UIBezierPath.init(arcCenter: CGPointMake(self.frame.width/2, self.frame.height/2), radius: 50, startAngle: 0, endAngle:CGFloat(M_PI*2) , clockwise: true)
            UIColor.blueColor().setFill()
            UIColor.greenColor().setStroke()
            path.fill()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        UIScreen.mainScreen().bounds.size.width
        self.frame.origin = CGPointMake((UIScreen.mainScreen().bounds.size.width-100)/2,(150-100)/2)
        self.frame.size = CGSizeMake(100, 100)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

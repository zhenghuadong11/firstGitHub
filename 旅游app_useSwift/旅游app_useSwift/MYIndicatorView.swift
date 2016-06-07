//
//  MYIndicatorView.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/24.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYIndicatorView: UIView {

    override func drawRect(rect: CGRect) {
        let x = self.frame.origin.x
        let y = self.frame.origin.y
        let width = self.frame.width
        let height = self.frame.height
        

        
        let path = UIBezierPath.init()
        path.moveToPoint(CGPointMake(0, height/2))
        path.addLineToPoint(CGPointMake(width/3*2, 0))
        path.addLineToPoint(CGPointMake(width, height/2))
        path.addLineToPoint(CGPointMake(width/3*2,height))
        path.closePath()
        path.fill()
    }

}

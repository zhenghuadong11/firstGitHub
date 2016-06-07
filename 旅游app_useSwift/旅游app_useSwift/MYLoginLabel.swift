//
//  MYLoginLabel.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/5/1.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYLoginLabel: UILabel {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        UIScreen.mainScreen().bounds.size.width
        self.frame.origin = CGPointMake((UIScreen.mainScreen().bounds.size.width-100)/2,(150-100)/2)
        self.frame.size = CGSizeMake(100, 100)
        self.hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

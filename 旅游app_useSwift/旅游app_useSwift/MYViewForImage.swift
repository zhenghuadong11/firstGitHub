//
//  MYViewForImage.swift
//  rmp
//
//  Created by zhenghuadong on 16/4/24.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYViewForImage: UIView {

    var imageView:UIImageView = UIImageView()

    var label:UILabel = UILabel()
    
    
    override func didMoveToSuperview() {
        self.addSubview(imageView)
        self.addSubview(label)
    }
    
}

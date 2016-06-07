//
//  MYOneTurnView.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/24.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYOneTurnView: UIView {

    var startAngle:CGFloat?
    var endAngle:CGFloat?
    var oneAngle:CGFloat?
    var viewForImage:MYViewForImage=MYViewForImage()
    var image:UIImage?
    var name:String?
    
    override func didMoveToSuperview() {
        
        
        
        let angle = (endAngle! - startAngle!)
        let r = self.frame.width/2
        viewForImage.frame.size = CGSizeMake(sin(angle/2)*r*2, r)
        
        viewForImage.layer.anchorPoint = CGPointMake(0.5, 1)
        viewForImage.layer.position = self.center
        self.addSubview(viewForImage)
        
        viewForImage.imageView.image = image

        
        viewForImage.imageView.frame.size = CGSizeMake(viewForImage.frame.width * 0.33, viewForImage.frame.height * 0.33)
        viewForImage.imageView.layer.position = CGPointMake(viewForImage.frame.width * 0.335, viewForImage.frame.height * 0.335)
        viewForImage.imageView.layer.anchorPoint = CGPointMake(0.5, 0.5)
//        viewForImage.imageView.snp_makeConstraints { (make) in
//            make.center.equalTo(viewForImage)
//            make.height.equalTo(viewForImage).multipliedBy(0.33)
//            make.width.equalTo(viewForImage).multipliedBy(0.33)
//        }
        
        
        viewForImage.label.text = name
        viewForImage.label.textAlignment = NSTextAlignment.Center
        viewForImage.label.snp_makeConstraints { (make) in
            make.bottom.equalTo(viewForImage.imageView.snp_top)
            make.height.equalTo(30)
            make.width.equalTo(viewForImage.imageView)
            make.centerX.equalTo(viewForImage)
        }
        viewForImage.layer.transform = CATransform3DMakeRotation(endAngle!-oneAngle!+oneAngle!/2+3.14/2, 0, 0, 1)
        
    }
    override func drawRect(rect: CGRect) {
        
        let path = UIBezierPath.init()
        path.moveToPoint(self.center)
        path.addArcWithCenter(self.center, radius: self.frame.width/2, startAngle: startAngle!, endAngle:endAngle!,clockwise: true)
        MYRandColor().setFill()
        path.closePath()
        
        path.fill()
        
    }


}

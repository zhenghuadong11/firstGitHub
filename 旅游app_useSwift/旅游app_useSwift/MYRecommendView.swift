//
//  MYRecommendView.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/17.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit

class MYRecommendView: UIView {
    var _imageView:UIImageView?
    var _nameLabel:UILabel?
    var _recommendLabel:UILabel?
    
    var _recommendModel:MYRecommendModel{
        set{
             self._recommendModelTmp = newValue
            self.setUpSubViewsWithRecommendModel(newValue)
        }
        get
        {
             return self._recommendModelTmp!
        }
    
    }
    var _recommendModelTmp:MYRecommendModel?
    
    
    func setUpSubViewsWithRecommendModel(recommendModel:MYRecommendModel) -> Void{
        
           self.createSubViews()
           self._imageView?.image = UIImage(named: recommendModel.picture!)
        
           self._nameLabel?.text = recommendModel.name
           _nameLabel?.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
           _nameLabel?.font = UIFont.systemFontOfSize(20)
   
    }
    
    func createSubViews() -> Void {
        let imageView:UIImageView = UIImageView()
        self._imageView = imageView
        imageView.backgroundColor = MYRandColor()
        self.addSubview(imageView)
        
        
        
        let nameLabel:UILabel = UILabel()
        self._nameLabel = nameLabel
       
        self.addSubview(nameLabel)
       
        
        
//        let recommendLabel:UILabel = UILabel()
//        self._recommendLabel = recommendLabel
//        recommendLabel.backgroundColor = UIColor.grayColor()
//        recommendLabel.alpha = 0.5
//        recommendLabel.textAlignment = NSTextAlignment.Center
//        self.addSubview(recommendLabel)
        
    }
    
    
    override func layoutSubviews() {
        
         self._imageView?.frame = self.bounds
         self._nameLabel?.frame = CGRectMake(0, 0,self.frame.width,self.frame.height/4)
//         self._recommendLabel?.frame = CGRectMake(0, self.frame.height*3/4,self.frame.width, self.frame.height/4)
    }
    
}
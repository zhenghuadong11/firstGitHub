//
//  MYScenicSpotView.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/18.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit
class MYScenicSpotShowView: UIView {
    
    var _imageNames:Array<String>!{
        set{
            _imageNamesTmp = newValue
            self.createAndSetUpImageViewWith(newValue)
        }
        get{
            return _imageNamesTmp!
        }
    }
    var _imageNamesTmp:Array<String>?
    
    var _name:String!{
        set{
            _nameTmp = newValue
            self.createAndSetUpNameLabelWith(newValue)
           
        }
        get
        {
            return _nameTmp
        }
     }
    var _nameTmp:String?
    
    
    var _one_word:String!{
        set{
            _one_wordTmp = newValue
             self.createAndSetUpOne_wordLabelWith(newValue)
        }
        get
        {
            return _one_wordTmp
        }
    }
    var _one_wordTmp:String?
    
   var _imageView:MYScenicSpotTranformImageView! = MYScenicSpotTranformImageView()
   var _nameLabel:UILabel! = UILabel()
   var _one_wordLabel:UILabel! = UILabel()
   var _shadowView:UIView! = UIView()
    
    
  func createAndSetUpImageViewWith(imageNames:Array<String>) ->Void{
        _imageView.imageNames = imageNames
    
    }
    
    func createAndSetUpNameLabelWith(name:String) -> Void {
     
        _nameLabel.text = name
        _nameLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
        
    }
    func createAndSetUpOne_wordLabelWith(one_word:String) -> Void {
        
        _one_wordLabel.text = one_word
        _one_wordLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)

        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        //下次坚决传模型。恶心死了
        
        self.bringSubviewToFront(_imageView!)
        self.bringSubviewToFront(_shadowView!)
        self.bringSubviewToFront(_nameLabel!)
        self.bringSubviewToFront(_one_wordLabel!)
        
        
        _imageView?.frame = self.bounds
        
        
        _shadowView?.snp_makeConstraints(closure: { (make) in
            make.right.left.bottom.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.25)
        })
        
        _nameLabel?.snp_makeConstraints(closure: { (make) in
            make.left.right.top.equalTo(_shadowView!)
            make.height.equalTo(_shadowView!).multipliedBy(0.5)
        })
       
        _one_wordLabel?.snp_makeConstraints(closure: { (make) in
            make.left.right.bottom.equalTo(_shadowView!)
            make.height.equalTo(_shadowView!).multipliedBy(0.5)
        })
    }
    
    override func didMoveToSuperview() {
        self.addSubview(_imageView)
        self.addSubview(_nameLabel)
        self.addSubview(_one_wordLabel)
        self.addSubview(_shadowView)
        _shadowView.backgroundColor = UIColor.grayColor()
        _shadowView.alpha = 0.5
        
    }
    
    
}
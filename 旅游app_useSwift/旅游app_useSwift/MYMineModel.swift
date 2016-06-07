//
//  MYMineModel.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/19.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation

class  MYMineModel:NSObject {
    
    static let _shareMineModel = MYMineModel()
    var headImageButton:MYLoginButton = {
       let button = MYLoginButton()
        button.hidden = true
       return button
    }()
    var nameLabelButton = MYLoginLabel()
    var loginLabelButton = MYLoginButton()
    var basicAnimation:CABasicAnimation?
    var name:String?
    var passWord:String?
    var image:UIImage?
    var remenberPassWord:Bool =
    {
          let path = NSBundle.mainBundle().pathForResource("nowUser.plist", ofType: nil)
          let array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
          if array?.count == 0
          {
              return false
          }
          return true
    }()
}
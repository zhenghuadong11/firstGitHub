//
//  MYZhifuModel.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/23.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit


class MYZhifuModel: NSObject {
    var date:NSDate?
    var num:String?
    var name:String?
    var user:String?
    var one_word:String?
    var picture:String?
    var scenicNum:String?
    var ticketNum:String?
    var money:String?
    
   static var zhifuModel:MYZhifuModel = MYZhifuModel()
   static func shareZhifuModel() -> MYZhifuModel {
          return zhifuModel
    }
    
}

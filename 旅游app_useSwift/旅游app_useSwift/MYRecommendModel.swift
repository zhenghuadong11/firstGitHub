//
//  MYRecommendModel.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/17.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation

class MYRecommendModel: NSObject {
    
    var name:String?
    var num:String?
    var picture:String?
    var oneWordToRecommend:String?
    
    
    
    
    func recommenModelWithDict(dict:NSObject) -> MYRecommendModel {
        
        return MYRecommendModel(dict:dict as! [String: AnyObject])
    }
    
    init(dict:[String:AnyObject]){
       super.init()
       
       self.setValue(dict["name"], forKey: "name")
       self.setValue(dict["num"], forKey: "num")
       self.setValue(dict["picture"], forKey: "picture")
       self.setValue(dict["oneWordToRecommend"], forKey: "oneWordToRecommend")
    }
    
}
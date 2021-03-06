//
//  MYDiffrentWithAgoModel.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/17.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation

class MYDiffrentWithAgoModel: NSObject {
    
    var name:String?
    var num:String?
    var picture:String?
    var oneWordToRecommend:String?
    var money:String?
    var spot:String?
    
    
    
    func diffrentWithAgoModelWithDict(dict:NSObject) -> MYRecommendModel {
        
        return MYRecommendModel(dict:dict as! [String: AnyObject])
    }
    
    init(dict:[String:AnyObject]){
        super.init()
        
        self.setValue(dict["name"], forKey: "name")
        self.setValue(dict["num"], forKey: "num")
        self.setValue(dict["picture"], forKey: "picture")
        self.setValue(dict["oneWordToRecommend"], forKey: "oneWordToRecommend")
        self.setValue(dict["money"], forKey: "money")
        self.setValue(dict["spot"], forKey: "spot")
    }
    
}
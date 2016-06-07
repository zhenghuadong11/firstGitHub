//
//  MYScenicSpotMessageModel.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/18.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation

class MYScenicSpotMessageModel: NSObject {
    
    var name:String?
    var num:String?
    var picture:Array<String>?
    var oneWordToRecommend:String?
    var money:String?
    var evaluetion:String?
    var phone:String?
    var spot:String?
    var setMeal:String?
    var buyNeedKnow:String?
    
    func diffrentWithAgoModelWithDict(dict:NSObject) -> MYRecommendModel {
        
        return MYRecommendModel(dict:dict as! [String: AnyObject])
    }
    
    init(dict:[String:AnyObject]){
        super.init()
        
        self.setValue(dict["name"], forKey: "name")
        self.setValue(dict["num"], forKey: "num")
        self.picture = dict["picture"] as? Array<String>
        self.setValue(dict["oneWordToRecommend"], forKey: "oneWordToRecommend")
        self.setValue(dict["money"], forKey: "money")
        self.setValue(dict["evaluetion"], forKey: "evaluetion")
        self.setValue(dict["phone"], forKey: "phone")
        self.setValue(dict["spot"], forKey: "spot")
        self.setValue(dict["setMeal"], forKey: "setMeal")
        self.setValue(dict["buyNeedKnow"], forKey: "buyNeedKnow")
    }
    
}
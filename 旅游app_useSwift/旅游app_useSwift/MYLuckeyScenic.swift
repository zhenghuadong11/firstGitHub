//
//  MYLuckeyScenic.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/25.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//



import Foundation

class MYLuckeyScenic: NSObject {
    
    var name:String?
    var num:String?
    var picture:String?

   static func luckeyScenicModelWithDict(dict:NSObject) -> MYLuckeyScenic {
        
        return MYLuckeyScenic(dict:dict as! [String: AnyObject])
    }
    
    init(dict:[String:AnyObject]){
        super.init()
        self.setValue(dict["name"], forKey: "name")
        self.setValue(dict["num"], forKey: "num")
        self.setValue(dict["picture"], forKey: "picture")
    }
    
}
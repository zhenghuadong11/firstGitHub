//
//  MYScenicSpotEvaluetionModel.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/21.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYScenicSpotEvaluetionModel: NSObject {

    var evalution:String?
    var num:String?
    var star:String?
    var user:String?
    var evalutionNum:String?
    var images:Array<String>?
    static  func scenicSpotEvaluetionModelWithDict(dict:NSObject) -> MYScenicSpotEvaluetionModel {
        
        return MYScenicSpotEvaluetionModel(dict:dict as! [String: AnyObject])
    }
    
    init(dict:[String:AnyObject]){
        super.init()
        
        self.setValue(dict["evalution"], forKey: "evalution")
        self.setValue(dict["num"], forKey: "num")
        self.setValue(dict["star"], forKey: "star")
        self.setValue(dict["user"], forKey: "user")
        self.setValue(dict["evalutionNum"], forKey: "evalutionNum")
        self.images = dict["images"] as? Array<String>
    }
}

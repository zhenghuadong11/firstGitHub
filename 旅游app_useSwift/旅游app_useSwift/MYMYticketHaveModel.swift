//
//  MYMYticketHaveModel.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/26.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYMYticketHaveModel: NSObject {
    var date:NSDate?
    var num:String?
    var name:String?
    var user:String?
    var one_word:String?
    var picture:String?
    var scenicNum:String?
    var ticketNum:String?
    var isEvaluation:String?
    static func myTicketHaveModel(dict:[String:AnyObject]) -> MYMYticketHaveModel
    {
        return MYMYticketHaveModel(dict:dict)
    }
    init(dict:[String:AnyObject]) {
        super.init()
        
        self.setValue(dict["name"], forKey: "name")
        self.setValue(dict["date"], forKey: "date")
        self.setValue(dict["num"], forKey: "num")
        self.setValue(dict["user"], forKey: "user")
        self.setValue(dict["one_word"], forKey: "one_word")
        self.setValue(dict["picture"], forKey: "picture")
        self.setValue(dict["scenicNum"], forKey: "scenicNum")
        self.setValue(dict["ticketNum"], forKey: "ticketNum")
        self.setValue(dict["isEvaluation"], forKey: "isEvaluation")
    }
}

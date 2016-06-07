//
//  MYSetUpLoginTableViewCell.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/5/1.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYSetUpLoginTableViewCell: UITableViewCell {

    @IBAction func switchClick(sender: UISwitch) {
        if sender.on == true
        {
             MYMineModel._shareMineModel.remenberPassWord = true
            if MYMineModel._shareMineModel.name != nil
            {
                let path = NSBundle.mainBundle().pathForResource("nowUser", ofType: "plist")
                var array = Array<[String:AnyObject]>()
                let dict:[String:AnyObject] = ["user":MYMineModel._shareMineModel.name!,"passWord":MYMineModel._shareMineModel.passWord!]
                array.append(dict)
                (array as NSArray).writeToFile(path!, atomically: true)
            }
        }
        else
        {
            MYMineModel._shareMineModel.remenberPassWord = false
            let path = NSBundle.mainBundle().pathForResource("nowUser", ofType: "plist")
            var array = Array<[String:AnyObject]>()
            (array as NSArray).writeToFile(path!, atomically: true)
        }
        
    }

    @IBOutlet weak var sw: UISwitch!

   
    static func setUpLoginTableViewCellWithTableView(tableView:UITableView) -> MYSetUpLoginTableViewCell
    {
           var cell = tableView.dequeueReusableCellWithIdentifier("MYSetUpLoginTableViewCell") as? MYSetUpLoginTableViewCell
           if cell == nil
           {
            cell = NSBundle.mainBundle().loadNibNamed("MYSetUpLoginTableViewCell", owner: nil, options: nil).first as? MYSetUpLoginTableViewCell
           }
          return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        let path = NSBundle.mainBundle().pathForResource("nowUser.plist", ofType: nil)
        let array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
        if array?.count == 0
        {
            self.sw.on = false
            return
        }
        
      
        self.sw.on = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

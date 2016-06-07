//
//  MYSetUpViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/17.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit

class MYSetUpViewController:  UIViewController,UITableViewDelegate,UITableViewDataSource{
    var _tableView = UITableView()
    
    override func viewDidLoad() {
        
        let titleLabel = UILabel()
        titleLabel.text = "设置"
        titleLabel.frame = CGRectMake(0, 0, 100, 30)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
        
        self.navigationItem.titleView = titleLabel
        _tableView.frame = self.view.bounds
        _tableView.bounces = false
        _tableView.delegate = self
        _tableView.dataSource = self
        self.view.addSubview(_tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if indexPath.row == 0
        { var setUpcell = MYSetUpTableViewCell.setUpTableViewWithTableView(tableView)
          setUpcell.textLabel?.text = "背景音乐"
          cell = setUpcell
        }
        else if indexPath .row == 1
        {
           var setUpLoginCell = MYSetUpLoginTableViewCell.setUpLoginTableViewCellWithTableView(tableView)
            
           
//            = NSBundle.mainBundle().loadNibNamed("MYSetUpLoginTableViewCell", owner: self, options: nil).first as! MYSetUpLoginTableViewCell
            
            cell = setUpLoginCell
        }
        print(cell)
        return cell!
    }
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 1000
//    }
    
    
}
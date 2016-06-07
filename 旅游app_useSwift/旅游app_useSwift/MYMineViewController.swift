///Users/zhenghuadong/Desktop/旅游app_useSwift/旅游app_useSwift.xcodeproj
//  MYMineViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/17.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit

class MYMineViewController:  UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    let headImageView = UIImageView()
    let tableView = UITableView()
    var loginButton:UIButton?
    
    override func viewDidLoad() {
        
        let titleLabel = UILabel()
        titleLabel.text = "我的"
        titleLabel.frame = CGRectMake(0, 0, 100, 30)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
        
        self.navigationItem.titleView = titleLabel
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.rightBarButtonItem = buttonBarItem("login", target: self, action: #selector(loginClick))
        self.setUpHeadView()
        self.setUpTableView()
       
        
        
    }
    func setUpHeadView() -> Void {
        self.view.addSubview(self.headImageView)
        self.headImageView.image = UIImage.init(named: "login_back")
        self.headImageView.userInteractionEnabled = true
        self.headImageView.frame = CGRectMake(0, 64, self.view.frame.width, 150)
        self.headImageView.backgroundColor = MYRandColor()
        
        
        let loginButton = MYMineModel._shareMineModel.loginLabelButton
        
        loginButton.setTitle("登陆", forState: UIControlState.Normal)
        
        let headImageButton = MYMineModel._shareMineModel.headImageButton
        headImageButton.setImage(getOvalInRect(UIImage.init(named: "none_login")!), forState: UIControlState.Normal)
        
        headImageButton.addTarget(self, action: #selector(loginClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        let nameLabelButton = MYMineModel._shareMineModel.nameLabelButton
        nameLabelButton.textColor = UIColor.orangeColor()
        
        
        
        self.headImageView.addSubview(headImageButton)
        self.headImageView.addSubview(nameLabelButton)
        self.headImageView.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(loginClick), forControlEvents: UIControlEvents.TouchUpInside)
        self.loginButton = loginButton
        
        let basicAnimation = CABasicAnimation.init(keyPath: "transform.translation.y")
        MYMineModel._shareMineModel.basicAnimation = basicAnimation
        
        basicAnimation.autoreverses = true
        basicAnimation.duration = 2

        basicAnimation.toValue = 10
        basicAnimation.repeatCount = MAXFLOAT
        loginButton.layer.addAnimation(basicAnimation, forKey: nil)
        headImageButton.layer.addAnimation(basicAnimation, forKey: nil)
    }
    
    func setUpTableView() -> Void {
        self.view.addSubview(self.tableView)
        self.tableView.frame = CGRectMake(0,64+150, self.view.frame.width, self.view.frame.height-64-150)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return 4
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
           return 60
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = MYMineViewTableViewCell.mineViewTableViewCellWithTableView(tableView)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        switch indexPath.row {
        case 0:
        
       
             cell.myLabel.text = "我的最爱"
             cell.myLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
             cell.myImageView.image = UIImage.init(named: "collect")
        case 1:
             cell.myLabel.text = "幸运一转"
             cell.myLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
             cell.myImageView.image = UIImage.init(named: "turntable")
        case 2:
            cell.myLabel.text = "我的门票"
            cell.myLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
            cell.myImageView.image = UIImage.init(named: "ticket")
            
        default:
            cell.myLabel.text = "更改密码"
            cell.myLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
            cell.myImageView.image = UIImage.init(named: "changePassWord")
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
              self.clickCollectButton()
        case 1:
              self.luckyButonClick()
        case 2:
              self.myTicketShowClick()
            
        default:
              self.changePassWordButtonClick()
        }
    }
    
      func clickCollectButton() {
        
            self.navigationController?.pushViewController(MYMineCollectViewController(), animated: true)
    }
    
    
      func luckyButonClick() {
        
        self.navigationController?.pushViewController(MYTurntableViewController(), animated: true)
        
    }

      func changePassWordButtonClick() {
         if MYMineModel._shareMineModel.name == nil {
              let alertController = UIAlertController.init(title: "还没登录", message: "请您先登录", preferredStyle: UIAlertControllerStyle.Alert)
              let okAction = UIAlertAction.init(title: "好的", style: UIAlertActionStyle.Default, handler: nil)
              let loginAction = UIAlertAction.init(title: "前往登陆", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) in
                   self.loginClick()
              })
              alertController.addAction(okAction)
              alertController.addAction(loginAction)
             self.presentViewController(alertController, animated: true, completion: nil)
            
            
        }
        
        let alertController = UIAlertController.init(title: "更改密码", message: "请输入您的新密码", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField:UITextField) in
                   textField.placeholder = "新的密码"
        }
        let okAction = UIAlertAction.init(title: "更改", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            let path = NSBundle.mainBundle().pathForResource("user", ofType: "plist")
            
            var array:Array<[String:AnyObject]>? = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
            let newPassWord = alertController.textFields![0].text
            
            for var i1 in 0..<array!.count
            {    var dict:[String:AnyObject] = array![i1]
                 if dict["name"] as! String == MYMineModel._shareMineModel.name!
                 {
                       dict["passWord"] = newPassWord
                       array![i1] = dict
                 }
                
            }
            (array as! NSArray).writeToFile(path!, atomically: true)
            
        }
        let loginAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Cancel, handler:nil)
        alertController.addAction(okAction)
        alertController.addAction(loginAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
   
    
    func myTicketShowClick() {
        if MYMineModel._shareMineModel.name == nil {
               _loginClick(self)
               return
        }
        
        let showTicketViewController = MYMineShowTicketViewController()
  
        self.navigationController?.pushViewController(showTicketViewController,animated: true)
        
    }
    
    
    @IBOutlet weak var myTicketShow: UIButton!
    
    
    func loginClick() -> Void {
    
         _loginClick(self)
    
    }
    
    override func viewDidAppear(animated: Bool) {
        MYMineModel._shareMineModel.headImageButton.layer.addAnimation(MYMineModel._shareMineModel.basicAnimation!, forKey: nil)
        MYMineModel._shareMineModel.loginLabelButton.layer.addAnimation(MYMineModel._shareMineModel.basicAnimation!, forKey: nil)
    }
    
   
    
}

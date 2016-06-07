//
//  MYAllDefine.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/17.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit
func MYRandColor() -> UIColor {
    
    return UIColor.init(colorLiteralRed: (Float)(rand()%256)/255, green:(Float)(rand()%256)/255 , blue: (Float)(rand()%256)/255, alpha: 1.0)
}

func buttonBarItem(imageName:String,target:NSObject,action:Selector) -> UIBarButtonItem {
    let button = UIButton.init(type: UIButtonType.Custom)
    button.frame = CGRectMake(0, 0, 30, 30)
    button.setImage(UIImage.init(named: imageName), forState: UIControlState.Normal)
    button.addTarget(target, action:action, forControlEvents: UIControlEvents.TouchUpInside)
    let barButton  = UIBarButtonItem.init(customView: button)
    return barButton
}


func _loginClick(viewController:UIViewController) -> Void {
    
    if MYMineModel._shareMineModel.name != nil {
        let alertController1 = UIAlertController.init(title: "已经登陆", message: "是否退出登录", preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Cancel, handler:nil)
        let changeAction = UIAlertAction.init(title: "切换帐号", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) in
            MYMineModel._shareMineModel.name = nil
            MYMineModel._shareMineModel.passWord = nil
            MYMineModel._shareMineModel.image = nil
            UIView.animateWithDuration(2.0, animations: {
                   MYMineModel._shareMineModel.headImageButton.frame.origin.x += 50
                   MYMineModel._shareMineModel.nameLabelButton.frame.origin.x -= 50
                
                }, completion: { (bool:Bool) in
                    MYMineModel._shareMineModel.headImageButton.hidden = true
                    MYMineModel._shareMineModel.nameLabelButton.hidden = true
                    MYMineModel._shareMineModel.loginLabelButton.hidden = false
            })
            
            
          
            _loginClick(viewController)
        })
        let leaveAction = UIAlertAction.init(title: "推出登陆", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) in
            MYMineModel._shareMineModel.name = nil
            MYMineModel._shareMineModel.passWord = nil
            MYMineModel._shareMineModel.image = nil
            UIView.animateWithDuration(2.0, animations: {
                MYMineModel._shareMineModel.headImageButton.frame.origin.x += 50
                MYMineModel._shareMineModel.nameLabelButton.frame.origin.x -= 50
                }, completion: { (bool:Bool) in
                    MYMineModel._shareMineModel.headImageButton.hidden = true
                    MYMineModel._shareMineModel.nameLabelButton.hidden = true
                    MYMineModel._shareMineModel.loginLabelButton.hidden = false
            })
        })
        var title:String?
        if MYMineModel._shareMineModel.image == nil
        {
            title = "上传头像"
        }
        else
        {
            title = "修改头像"
        }
        let changeImage = UIAlertAction.init(title:title, style: UIAlertActionStyle.Default, handler: { (alertAction:UIAlertAction) in
                viewController.presentViewController(MYHeadImageSendViewController(), animated: true, completion: nil)
        })
        alertController1.addAction(cancelAction)
        alertController1.addAction(changeAction)
        alertController1.addAction(leaveAction)
        alertController1.addAction(changeImage)
        viewController.presentViewController(alertController1, animated: true, completion: nil)
        return
    }
    
    let alertController = UIAlertController.init(title: "登陆", message: "宜州欢迎你", preferredStyle: UIAlertControllerStyle.Alert)
    
    let path = NSBundle.mainBundle().pathForResource("nowUser", ofType: "plist")
    var array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
    var text1:String?
    var text2:String?
    
    if array?.count == 0
    {
        text1 = ""
        text2 = ""
    }
    else
    {
       text1 = array![0]["user"] as? String
       text2 = array![0]["passWord"] as? String
    }
    alertController.addTextFieldWithConfigurationHandler {
        (textField: UITextField!) -> Void in
        textField.frame.size.height = 50
        textField.text = text1
        textField.placeholder = "登录"
    }
    alertController.addTextFieldWithConfigurationHandler {
        (textField: UITextField!) -> Void in
        textField.placeholder = "密码"
        textField.text = text2
        textField.secureTextEntry = true
    }
    
    
    
    let alertAction1 = UIAlertAction.init(title: "登陆", style: UIAlertActionStyle.Default) { (alertAction:UIAlertAction) in
          login(viewController,alertController: alertController)

    }
    
    let alertAction2 = UIAlertAction.init(title: "注册", style: UIAlertActionStyle.Default) { (alertAction:UIAlertAction) in
        viewController.presentViewController(MYRegisterViewController(), animated: true, completion: nil)

    }
    let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Cancel, handler:nil)
    alertController.addAction(alertAction1)
    alertController.addAction(alertAction2)
    alertController.addAction(cancelAction)
    
    viewController.presentViewController(alertController, animated: true, completion: nil)
    
}



func login(viewController:UIViewController,alertController:UIAlertController)
{
    let nameTextField = alertController.textFields?[0]
    let passWordTextField = alertController.textFields?[1]
    
    let path = NSBundle.mainBundle().pathForResource("user", ofType: "plist")
    
    let array:Array<[String:AnyObject]>? = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
    
    for var dict:[String:AnyObject] in array!
    {
        if nameTextField?.text! == dict["name"] as! String && passWordTextField?.text! == dict["passWord"] as! String
        {
            MYMineModel._shareMineModel.name = nameTextField?.text
            MYMineModel._shareMineModel.passWord = passWordTextField?.text
            var path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
            
            path = path?.stringByAppendingString("/ImageFile/")
            
            if dict["headImage"] as! String == "" || dict["headImage"] as! String == "none_login"
            {
                 MYMineModel._shareMineModel.image = getOvalInRect(UIImage.init(named: "none_login")!)
            }
            else
            {
               path = path?.stringByAppendingString(dict["headImage"] as! String)
               MYMineModel._shareMineModel.image = UIImage.init(contentsOfFile: path!)
            }
      
            MYMineModel._shareMineModel.headImageButton.setImage(MYMineModel._shareMineModel.image, forState: UIControlState.Normal)
            MYMineModel._shareMineModel.nameLabelButton.text = nameTextField?.text
            MYMineModel._shareMineModel.headImageButton.hidden = false
            MYMineModel._shareMineModel.nameLabelButton.hidden = false
             MYMineModel._shareMineModel.loginLabelButton.hidden = true
            
            
            
            UIView.animateWithDuration(2.0, animations: {
                MYMineModel._shareMineModel.headImageButton.frame.origin.x -= 50
                MYMineModel._shareMineModel.nameLabelButton.frame.origin.x += 50
                }, completion: { (bool:Bool) in
                   
            })
            
            if MYMineModel._shareMineModel.remenberPassWord == true
            {
                let path = NSBundle.mainBundle().pathForResource("nowUser", ofType: "plist")
                var array = Array<[String:AnyObject]>()
                let dict:[String:AnyObject] = ["user":MYMineModel._shareMineModel.name!,"passWord":MYMineModel._shareMineModel.passWord!]
                array.append(dict)
                (array as NSArray).writeToFile(path!, atomically: true)
            }
            
            return
        }
    }
    var errorMessage:String?
    
    if(nameTextField?.text == "")
    {
        errorMessage = "名字不能是空"
    }
    else
    {
        errorMessage = "账号密码错误"
    }
    
    
    let promptAlertController = UIAlertController.init(title: "登陆失败", message: errorMessage, preferredStyle: UIAlertControllerStyle.ActionSheet)
    let alertActionx = UIAlertAction.init(title: "再次登陆", style: UIAlertActionStyle.Default, handler: { (alertAction:UIAlertAction) in
        viewController.presentViewController(alertController, animated: true, completion: nil)
    })
    let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Cancel, handler:nil)
    promptAlertController.addAction(alertActionx)
    promptAlertController.addAction(cancelAction)
    viewController.presentViewController(promptAlertController, animated: true, completion:nil)
}

func searchKuang() -> UITextField {
    let searchTextField:UITextField = UITextField()
    searchTextField.backgroundColor=UIColor.grayColor()
    let imageView = UIImageView.init(image: UIImage.init(named: "search"))
    imageView.backgroundColor = MYRandColor()
    
    imageView.frame = CGRectMake(0, 0, 30, 30)
//    searchTextField.rightView = imageView
    searchTextField.leftView = imageView
//    searchTextField.leftViewRectForBounds(CGRectMake(0, 0, 30, 30))
    searchTextField.leftViewMode = UITextFieldViewMode.Always
    searchTextField.frame = CGRectMake(0, 0, 30, 30)
    return searchTextField
    
}

func getArrayFromPlist(plistName:String) -> Array<[String:AnyObject]>
{
    let path:String = NSBundle.mainBundle().pathForResource(plistName, ofType: nil, inDirectory: nil)!
    var array = NSArray.init(contentsOfFile: path) as! Array<[String:AnyObject]>
    return array
}

func getString(string:String,from:Int,to:Int) -> String {

    let range = Range<String.Index>(start:string.startIndex.advancedBy(from),end:string.startIndex.advancedBy(to+1))
    return  string.substringWithRange(range)
}

func getOvalInRect(image:UIImage) ->UIImage
{
    UIGraphicsBeginImageContextWithOptions(image.size, false, 1)
    
    let path = UIBezierPath.init(ovalInRect: CGRectMake(0,0, image.size.width, image.size.height))
    path.addClip()
    image.drawAtPoint(CGPointZero)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
    
}
func getCurrentTime() -> String {
     let formatter = NSDateFormatter.init()
     formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
     return formatter.stringFromDate(NSDate.init())
}

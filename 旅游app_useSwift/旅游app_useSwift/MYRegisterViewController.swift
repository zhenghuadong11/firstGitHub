//
//  MYRegisterViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/20.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYRegisterViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var judgeImageView: UIImageView!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        registerButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
       
        
        var trueString = string
//        if trueString == "" {
//            trueString = " "
//        }
   
        var newString:String = nameTextField.text!
        if ((nameTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)) <= range.location) {
             newString = newString + trueString
        }
        else
        {
//            if newString.containsString(trueString) {
                newString = (newString as! NSString).substringToIndex(range.location) as!String
//            }
//            else
//            {
//                 newString = trueString
//            }


        }
        
   
        if newString == ""
        {
            
            registerButton.enabled = false
            judgeImageView.image = UIImage.init(named: "false")
            return true
        }
        let path = NSBundle.mainBundle().pathForResource("user", ofType: "plist")
        var array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
        
        for var dict in array! {
          if newString == dict["name"] as! String
          {
            
            registerButton.enabled = false
            judgeImageView.image = UIImage.init(named: "false")
            return true
          }
        }
        
        
        registerButton.enabled = true
        judgeImageView.image = UIImage.init(named: "true")
        
        return true
    }
    

    @IBAction func cancel(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func registerClick(sender: AnyObject) {
        
        
        let path = NSBundle.mainBundle().pathForResource("user", ofType: "plist")
        var array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
    
        var dict:[String:AnyObject] = [String:AnyObject].init(dictionaryLiteral: ("name", nameTextField.text!),("passWord", passWordTextField.text!),("headImage",""))
        
        
        
        array?.append(dict)
        let arr = array as! NSArray
  
        arr.writeToFile(path!, atomically: true)
        
        let message = "您的帐号是"+nameTextField.text!+"密码是"+passWordTextField.text!
        let alertController = UIAlertController.init(title: "注册成功", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let action:UIAlertAction = UIAlertAction.init(title: "开始游览", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            
                   if MYMineModel._shareMineModel.name == nil
                   {
                        MYMineModel._shareMineModel.name = self.nameTextField!.text
                        MYMineModel._shareMineModel.passWord = self.passWordTextField!.text
                    
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
                    MYMineModel._shareMineModel.nameLabelButton.text = self.nameTextField.text
                    MYMineModel._shareMineModel.headImageButton.hidden = false
                    MYMineModel._shareMineModel.nameLabelButton.hidden = false
                    MYMineModel._shareMineModel.loginLabelButton.hidden = true
                    
                    UIView.animateWithDuration(2.0, animations: {
                        MYMineModel._shareMineModel.headImageButton.frame.origin.x -= 50
                        MYMineModel._shareMineModel.nameLabelButton.frame.origin.x += 50
                        }, completion: { (bool:Bool) in
                            
                    })

                   }
            
                   self.dismissViewControllerAnimated(false, completion: nil)
        }
        alertController.addAction(action)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
}

//
//  MYSetPassWordViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/22.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYSetPassWordViewController: UIViewController,UITextFieldDelegate,MYTextFieldDelegate{

    @IBOutlet weak var backVIew: UIView!
    var textFields = Array<UITextField>()
    var _index:Int = 0
    var nowRespontTextField:UITextField?
    var _key:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createAndSetUpTextField()
        textFields[0].becomeFirstResponder()
    }
    @IBAction func payButton(sender: AnyObject) {
        
        var passString:String = ""
        for var i1 in 0..<6
        {
           let onePass = rand()%10
           passString = passString + onePass.description
        }
        print(passString)
        
        let message:String = "您的门票:"+MYZhifuModel.shareZhifuModel().name!+(MYZhifuModel.shareZhifuModel().date?.description)!
        let alertController =  UIAlertController.init(title: "付款成功", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction:UIAlertAction = UIAlertAction.init(title: "好的,太方便了", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            
            
            let path:String = NSBundle.mainBundle().pathForResource("myPicker.plist", ofType: nil, inDirectory: nil)!
            var array = NSArray.init(contentsOfFile: path) as! Array<[String:AnyObject]>
            
            MYZhifuModel.shareZhifuModel().num = array.count.description
              
             let dict:[String:AnyObject] = ["name":MYZhifuModel.shareZhifuModel().name!,"user":MYZhifuModel.shareZhifuModel().user!,"num":MYZhifuModel.shareZhifuModel().num!,"date":MYZhifuModel.shareZhifuModel().date!,"one_word":MYZhifuModel.shareZhifuModel().one_word!,"picture":MYZhifuModel.shareZhifuModel().picture!,"scenicNum":MYZhifuModel.shareZhifuModel().scenicNum!,"ticketNum":MYZhifuModel.shareZhifuModel().ticketNum!,"money":MYZhifuModel.shareZhifuModel().money!,"pass":passString]
            array.append(dict)
            (array as NSArray).writeToFile(path, atomically: true)
            self._key = false
            self.setResignRespond()
            self._key = true
            
            self.dismissViewControllerAnimated(true, completion: nil)
      
        }
        let alertAction1:UIAlertAction = UIAlertAction.init(title: "好的,不太方便了", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            let path:String = NSBundle.mainBundle().pathForResource("myPicker", ofType:"plist", inDirectory: nil)!
            var array = NSArray.init(contentsOfFile: path) as! Array<[String:AnyObject]>
            
            let dict:[String:AnyObject] = ["name":MYZhifuModel.shareZhifuModel().name!,"user":MYZhifuModel.shareZhifuModel().user!,"num":MYZhifuModel.shareZhifuModel().num!,"date":MYZhifuModel.shareZhifuModel().date!,"one_word":MYZhifuModel.shareZhifuModel().one_word!,"picture":MYZhifuModel.shareZhifuModel().picture!,"scenicNum":MYZhifuModel.shareZhifuModel().scenicNum!,"ticketNum":MYZhifuModel.shareZhifuModel().ticketNum!,"money":MYZhifuModel.shareZhifuModel().money!,"pass":passString]
            
         
            array.append(dict)
            (array as NSArray).writeToFile(path, atomically: true)
            self._key = false
            self.setResignRespond()
            self._key = true
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(alertAction)
        alertController.addAction(alertAction1)
        self.presentViewController(alertController, animated: true) { 
            
        }
        
    }
    
   func setResignRespond()
   {
    for var tF in textFields {
        tF.resignFirstResponder()
    }
    
    }
    
    
    func createAndSetUpTextField() -> Void
    {
        for var i1:Int in 0..<6
        {
           var textField = MYTextField()
           textField.secureTextEntry = true
           backVIew .addSubview(textField)
           textFields.append(textField)
           textField.delegate = self
           textField.borderStyle = UITextBorderStyle.Line
           textField.keyboardType = UIKeyboardType.NumberPad
           textField.frame = CGRectMake((self.view.frame.width-300)/2+CGFloat(i1*50),200 , 50, 50)
           textField.keyInputDelegate = self
            
        }
    }
    
  
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        var index = 0
        for tField in textFields {
            if(textField == tField)
            {
                break;
            }
            index += 1
        }
        if textField.text != "" && string != ""
        {
            if  index+1<=5 {
                _index = index + 1
            }
            textField.resignFirstResponder()
        }
        return true
    }
    
   
    func textFieldDidEndEditing(textField: UITextField) {
        
         if _key == false
          {    return
           }
         textFields[_index].becomeFirstResponder()
         nowRespontTextField = textFields[_index]
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func deleteBackward() {
  
        if _index>0 {
            textFields[_index-1].becomeFirstResponder()
            _index -= 1
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

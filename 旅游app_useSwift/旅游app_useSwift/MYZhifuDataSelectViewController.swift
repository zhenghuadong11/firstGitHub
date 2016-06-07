//
//  MYZhifuDataSelectViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/22.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYZhifuDataSelectViewController: UIViewController,UITextFieldDelegate {
   weak var presentViewController:UIViewController?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    

    @IBOutlet weak var needMoneyLabel: UILabel!
    @IBOutlet weak var _textField: UITextField!
    var _totalMoney:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        _textField.keyboardType = UIKeyboardType.NumberPad
        _textField.delegate = self
      
        _totalMoney = MYZhifuModel.shareZhifuModel().money!
        needMoneyLabel.text = "需付款:"+MYZhifuModel.shareZhifuModel().money!+"元"
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func zhifuButtonClick(sender: AnyObject) {
        
        
        
        let zhifuViewController = MYZhifuViewController()
        MYZhifuModel.shareZhifuModel().date = datePicker.date
        MYZhifuModel.shareZhifuModel().ticketNum = _textField.text == "" ?"1":_textField.text!
        MYZhifuModel.shareZhifuModel().money = _totalMoney
        zhifuViewController.presentViewController = presentViewController
        self.dismissViewControllerAnimated(false, completion: nil)
        presentViewController?.presentViewController(zhifuViewController, animated: true, completion: nil)
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
     
      
        if string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)>1
        {
              return false
        }
        
        
        
        
        
     
        
        var newString:String = textField.text!
        if ((textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)) <= range.location) {
            if string != "" && (getString(string, from: 0, to: 0) < "0" || getString(string, from: 0, to: 0) > "9")
            {
                return false
            }
            newString = newString + string
        }
        else
        {
            newString = (newString as! NSString).substringToIndex(range.location) as!String
        }
        

        
        let num = Float.init(newString)!
        let oneMoney = Float(MYZhifuModel.shareZhifuModel().money!)!
        let totalMoney =  num * oneMoney
        
  
        _totalMoney = totalMoney.description
        needMoneyLabel.text = "需付款:"+totalMoney.description+"元"
        
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        _textField.resignFirstResponder()
    }
   
    
    

}

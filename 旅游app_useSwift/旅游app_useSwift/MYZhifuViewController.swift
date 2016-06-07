//
//  MYZhifuViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/22.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYZhifuViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var _backGroundImageView: UIImageView!
    @IBOutlet weak var passWordTextField: UITextField!
    weak var presentViewController:UIViewController?
    var ticketDate:NSDate?
    override func viewDidLoad() {
        super.viewDidLoad()
        let blur = UIBlurEffect.init(style: UIBlurEffectStyle.Light)
        let effectView = UIVisualEffectView.init(effect: blur)
        effectView.frame = self.view.bounds
        _backGroundImageView.addSubview(effectView)
 
       userTextField.leftViewMode = UITextFieldViewMode.Always
       let userImageView = UIImageView.init(image: UIImage.init(named: "z_user.png"))
       userImageView.frame = CGRectMake(0, 0, userTextField.frame.height,userTextField.frame.height)
       userTextField.leftView = userImageView
        
       passWordTextField.leftViewMode = UITextFieldViewMode.Always
        let passImageView = UIImageView.init(image: UIImage.init(named: "z_passWord.png"))
        passImageView.frame = CGRectMake(0, 0, passWordTextField.frame.height, passWordTextField.frame.height)
        passWordTextField.leftView = passImageView
        
    }

    @IBAction func loginButtonClick(sender: AnyObject) {
        
          self.dismissViewControllerAnimated(false, completion: nil)
          let setPassWordViewController = MYSetPassWordViewController()
        
          presentViewController?.presentViewController(setPassWordViewController, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//
//  MYEvaluationViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/27.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYEvaluationViewController: UIViewController,MYImageEvvaluationViewControllerDelegate {
    weak var _viewController:UIViewController?
    var _num:String?
    var _evalutionIndex:Int?
    var _myPickerHaveModel:MYMYticketHaveModel?
    var _buttons:Array<UIButton> = Array<UIButton>()
    @IBOutlet weak var textView: UITextView!
    var _star:Int = 0
    var imageNum = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
       for var i1 in 0..<5
       {
          var button = UIButton.init(type: UIButtonType.Custom)
          button.frame = CGRectMake(CGFloat(i1)*30+100, 80, 30, 30)
    
          button.setImage(UIImage.init(named: "hightLightStar"), forState: UIControlState.Selected)
          button.setImage(UIImage.init(named: "star_none"), forState: UIControlState.Normal)
          button.addTarget(self, action: #selector(buttonClick), forControlEvents: UIControlEvents.TouchUpInside)
          button.tag = i1
          _buttons.append(button)
          self.view.addSubview(button)
       }
        
        
    }
   
    @IBAction func cancelButtonClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    func buttonClick(sender:UIButton) -> Void {
        
        for i1 in 0...sender.tag {
            _buttons[i1].selected = true
        }
        
        _star = sender.tag+1
        if sender.tag+1 > 4
        {
            return
        }
        for i1 in sender.tag+1...4 {
            _buttons[i1].selected = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func evaluationButotnClick(sender: AnyObject) {
        let path = NSBundle.mainBundle().pathForResource("myPickerHave", ofType: "plist")
        if let _ = path
        {
            var array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
            var dict = array![_evalutionIndex!]
            
            array?.removeAtIndex(_evalutionIndex!)
            dict["isEvaluation"] = "true"
            
            
            array?.append(dict)
            (array! as NSArray).writeToFile(path!, atomically: true)
        }
        
        let pathEvaluetion = NSBundle.mainBundle().pathForResource("evaluetion", ofType: "plist")
        if let _ = pathEvaluetion
        {
            var array = NSArray.init(contentsOfFile: pathEvaluetion!) as? Array<[String:AnyObject]>
            var index = 0
            var path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
            path = path?.stringByAppendingString("/ImageFile/")
            
            var imageNames = Array<String>()
            for var view in self.textView.subviews
            {
                
                     if view.isKindOfClass(MYImageView)
                     {       var imagePath = path
                             let imageName = getCurrentTime()+index.description+rand().description
                             imageNames.append(imageName)
                             imagePath = imagePath?.stringByAppendingString(imageName)
                        
                             let imageView = (view as! UIImageView)
                        
                             print(imagePath)
                        
                             try?  UIImagePNGRepresentation(imageView.image!)?.writeToFile(imagePath!, options: NSDataWritingOptions.AtomicWrite)
                        
                            index += 1
                      }
            }
            
            print(imageNames)
            let dict:[String:AnyObject] = ["num":_num!,"evalution":textView.text,"star":_star.description,"user":MYMineModel._shareMineModel.name!,"evalutionNum":(array?.count)!.description,"images":imageNames]
            array?.append(dict)
            (array! as NSArray).writeToFile(pathEvaluetion!, atomically: true)
        }
        
        self.dismissViewControllerAnimated(true) {
            (self._viewController as! MYMineShowTicketViewController).setUpmyTicketHaveModels()
            (self._viewController as! MYMineShowTicketViewController)._tableView?.reloadData()
        }
        
    }
    
    @IBAction func addPicktureClick(sender: AnyObject) {
              let headImageController = MYImageEvvaluationViewController()
              headImageController.delegate = self
              self.presentViewController(headImageController, animated: true, completion: nil)
    }
    
    @IBAction func cancelImageClick(sender: AnyObject) {
          if self.imageNum == 0
          {
              return
           }
          self.textView.subviews.last?.removeFromSuperview()
          self.imageNum -= 1
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
           textView.resignFirstResponder()
    }
    func imageEvvaluationViewController(viewController: MYImageEvvaluationViewController, image: UIImage) {
        
           if self.imageNum == 8
           {
                return 
           }
           let imageView = MYImageView.init(image: image)
           self.textView.addSubview(imageView)
           self.imageNum += 1
    }
    
    
    override func viewDidLayoutSubviews() {
        
           var index = 0
           for var view in self.textView.subviews
           {
                if view.isKindOfClass(MYImageView)
                {
                    let width = self.textView.frame.width/4
                    let height = self.textView.frame.height/4
                    view.frame = CGRectMake(CGFloat(index%4)*width,CGFloat(index/4+2)*height,width,height)
                    index += 1
                }
           }
    }

}

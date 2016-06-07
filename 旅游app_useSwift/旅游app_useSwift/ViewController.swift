//
//  ViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/15.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var shadowView:UIView = UIView()
    var noteLabel:UILabel = UILabel()
     var timer:NSTimer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = MYRandColor()
        
        
        let tabarViewController:MYTabbarViewController = MYTabbarViewController()
        self.addChildViewController(tabarViewController)
        self.view .addSubview(tabarViewController.view)
        print("xiugaile")
//        shadowView.frame = CGRectMake(0, 64, self.view.frame.width,20)
//        self.view.addSubview(shadowView)
//        shadowView.alpha = 0.5
//        shadowView.backgroundColor = UIColor.whiteColor()
//        
//        noteLabel.text = "今晚会有暴雨"
//        noteLabel.frame = shadowView.bounds
//        noteLabel.frame.origin.x = self.view.frame.width
//        shadowView.addSubview(noteLabel)
//        timer =  NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(timerClick), userInfo: nil, repeats: true)
    }
    
    
    func timerClick() -> Void {
        
        UIView.animateWithDuration(4.0) {
            self.noteLabel.frame = CGRectMake(-self.view.frame.width, 0, self.view.frame.width, 20)
         
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(4.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            self.noteLabel.frame = CGRectMake(self.view.frame.width, 0, self.view.frame.width, 20)
            
        })
    }
    
    deinit
    {
        timer?.invalidate()
        timer = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


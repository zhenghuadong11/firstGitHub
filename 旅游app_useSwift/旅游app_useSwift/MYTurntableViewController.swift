//
//  MYTurntableViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/23.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYTurntableViewController: UIViewController {
    
    @IBOutlet weak var turntableImageView: UIImageView!
    weak var _indeicatorView:MYIndicatorView?
    
    lazy var _lukeyModels:Array<MYLuckeyScenic> = {
        
        let path = NSBundle.mainBundle().pathForResource("lukeyScenic", ofType: "plist")
        let array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
        if array == nil
        {
            return Array<MYLuckeyScenic>()
        }
        var mArray = Array<MYLuckeyScenic>()
        for var dict in array!
        {
           mArray.append(MYLuckeyScenic.luckeyScenicModelWithDict(dict))
        }
        return mArray
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let r = turntableImageView.frame.width/3
        
        let view = MYIndicatorView()
        view.backgroundColor = UIColor.clearColor()
        view.frame = CGRectMake(0,0,r, 10)
        self.view.addSubview(view)
        view.layer.anchorPoint = CGPointMake(1,0.5)
        view.layer.position = turntableImageView.center
        
        _indeicatorView = view
        
        if _lukeyModels.count == 0
        {
              return
        }
        
        
        let angle = CGFloat((360.0/Double(_lukeyModels.count))/180*3.145)
        
        for i1 in 0..<_lukeyModels.count
        {
            let turnView = MYOneTurnView()
            turnView.image = UIImage.init(named: _lukeyModels[i1].picture!)
            turnView.name = _lukeyModels[i1].name!
            turnView.backgroundColor = UIColor.clearColor()
            turnView.frame = turntableImageView.bounds
            turnView.startAngle = CGFloat(i1)*angle
            turnView.endAngle = CGFloat(i1+1)*angle
            turnView.oneAngle = angle
            turntableImageView.addSubview(turnView)
        }

        
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        let oneAngle = 179
        let angle = rand()%1080+1080
        let miao = 10.0/Double(angle)
        let cishu = Int(angle/179)
        let shengyu = Int(angle%179)
        viewRotat(cishu, lastAngle: shengyu, miao: miao)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func viewRotat(cishu:Int,lastAngle:Int,miao:Double) -> Void {
        if(cishu == 0)
        {   return
        }
        if(cishu == 1)
        {
            UIView.animateWithDuration(miao*Double(lastAngle), animations: {
                self._indeicatorView?.layer.transform = CATransform3DRotate((self._indeicatorView?.layer.transform)!,CGFloat(Float(lastAngle)/180*3.145),0, 0, 1)
            })
            return
        }
        UIView.animateWithDuration(miao*179) {
            self._indeicatorView?.layer.transform = CATransform3DRotate((self._indeicatorView?.layer.transform)!,CGFloat(Float(179)/180*3.145),0, 0, 1)
            self.viewRotat(cishu-1, lastAngle: lastAngle, miao: miao)
        }
    }


    

}

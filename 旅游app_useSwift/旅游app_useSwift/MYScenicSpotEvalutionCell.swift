//
//  MYScenicSpotEvalutionCell.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/18.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit


class MYScenicSpotEvalutionCell: UITableViewCell {
    let cellID = "MYScenicSpotEvalutionCell"
    
    let _intervalView:UIView! = UIView()
    let _sumLabel = UILabel()
    
    var _num:String!{
        set{
             _numTmp = newValue
            let array = getArrayFromPlist("evaluetion.plist")
        
            var count:Int = 0
            var total:Float = 0
            
            for var dict in array {
                if dict["num"] as! String == newValue
                {
                     count += 1
                     total += Float.init((dict["star"] as! String))!
                }
            }
            if count == 0
            {
              _evalution = 0
            }
            else
            {
              _evalution = total/Float(count)
            }
            _sumLabel.text = "已有"+count.description+"人评价"
            _sumLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
            
            self.createEvaluetionButton()
            self.setUpEvalueTionButton(_evalution!)
        }
        get{
             return _numTmp
        }
    }
    var _numTmp:String?
    var _evalutionButtonTmp:UIButton?
    var _evalution:Float?

    
    
   func createEvaluetionButton() ->Void
   {
     if _evalutionButtonTmp != nil
     {
        return
     }
     for i1 in 0...4 {
        let button:UIButton = UIButton()
        _evalutionButtonTmp = button
        self.addSubview(button)
        button.setBackgroundImage(UIImage.init(named: "star_none"), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage.init(named: "hightLightStar.jpg"), forState: UIControlState.Selected)
      }
    }
    
    func setUpEvalueTionButton(evaluetion:Float) -> Void {
        
        let evaluetionInt = Int(evaluetion)
        var index:Int = 0
        for var view:UIView in self.subviews {
            if !view.isKindOfClass(UIButton) {
                continue
            }
            let button = view as! UIButton
            if index < evaluetionInt
            {
                button.selected = true
            }
            else
            {
                button.selected = false
            }
            
            index += 1
        }
        
    }
    
    
    static func scenicSpotEvalutionCellWithTableView(tableView:UITableView) -> MYScenicSpotEvalutionCell
    {
        
        var cell:MYScenicSpotEvalutionCell? = tableView.dequeueReusableCellWithIdentifier("MYScenicSpotEvalutionCell") as? MYScenicSpotEvalutionCell
        if cell == nil
        {
              cell = MYScenicSpotEvalutionCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "MYScenicSpotEvalutionCell")
        }
        
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var index:Int = 0
        
        for var view:UIView in self.subviews {
            if !view.isKindOfClass(UIButton) {
                continue
            }
            view.frame = CGRectMake(CGFloat(10+index*30),CGFloat(10.0), 30.0, 30.0)
           index += 1
        }
        _intervalView.snp_makeConstraints { (make) in
            
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(10)
        }
        _sumLabel.snp_makeConstraints { (make) in
            make.right.top.equalTo(self)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(100)
        }
    }
    
    override func didMoveToSuperview() {
       self.addSubview(_intervalView)
       self.addSubview(_sumLabel)
       _intervalView.backgroundColor = UIColor.grayColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
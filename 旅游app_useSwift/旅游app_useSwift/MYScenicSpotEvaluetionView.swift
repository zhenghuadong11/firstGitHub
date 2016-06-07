//
//  MYScenicSpotEvaluetionView.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/21.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYScenicSpotEvaluetionView: UIView {

    var _key:Int = Int(0)
    var _headerView:UIView = UIView()
    var _userLabel:UILabel = UILabel()
    var _starView:UIView = UIView()
    var _evaluetionLabel:UILabel = UILabel()
    var _headerViewTopView:UIView = UIView()
    var _headerViewBottonView:UIView = UIView()
    var height:CGFloat?
    var imageHeight:CGFloat?
    var userImageView = UIImageView()
    var viewForImageViews = UIView()
    
    var _evalution:MYScenicSpotEvaluetionModel{
        set{
            _evalutionTmp = newValue
            if _key == 0 {
                 createStarView()
                 createImageViews()
                _key += 1
            }
            setUpSubView()
            
        }
        get{
              return _evalutionTmp!
        }
    }
    var _evalutionTmp:MYScenicSpotEvaluetionModel?
    
    func createStarView() -> Void {
        
        for i1 in 0..<5 {
            var button = UIButton()
            button.frame = CGRectMake(CGFloat(i1*30), 0, 30, 27)
            button.setImage(UIImage.init(named: "star_none"), forState: UIControlState.Normal)
            button.setImage(UIImage.init(named: "hightLightStar"), forState: UIControlState.Selected)
            _starView.addSubview(button)
            
        }
        
    }
    func createImageViews() -> Void {
        print(self._evalution.images)
        
        if self._evalution.images!.count == 0
        {
            return
        }
        
        
        for i1 in 0..<self._evalution.images!.count {
              let imageView = UIImageView()
              self.viewForImageViews.addSubview(imageView)
              let width = (UIScreen.mainScreen().bounds.size.width-40)/4
              imageView.frame = CGRectMake(CGFloat(i1%4)*width,CGFloat(i1/4)*width, width, width)
            
              if Int.init(_evalution.evalutionNum!) == 0
              {
                  imageView.image = UIImage.init(named: self._evalution.images![i1])
              }
              else
              {
                 var path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
                 path = path?.stringByAppendingString("/ImageFile/")
                 path = path?.stringByAppendingString(String(_evalution.images![i1]))
                 imageView.image = UIImage.init(contentsOfFile: path!)
              }
        }
        
        
    }
    
    func setUpSubView() -> Void{
        
        if _evalution.user == "匿名用户"
        {
           _userLabel.text =  _evalution.user
           self.userImageView.image = getOvalInRect(UIImage.init(named: "none_login")!)
            
        }
        else
        {
           
          _userLabel.text = "用户:"+_evalution.user!
            let path = NSBundle.mainBundle().pathForResource("user", ofType: "plist")
            
            let array:Array<[String:AnyObject]>? = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
            
            for var dict:[String:AnyObject] in array!
            {
                if self._evalution.user == dict["name"] as! String
                {
                  
                    var path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
                    
                    path = path?.stringByAppendingString("/ImageFile/")
                    
                    if dict["headImage"] as! String == "" || dict["headImage"] as! String == "none_login"
                    {
                        self.userImageView.image = getOvalInRect(UIImage.init(named: "none_login")!)
                    }
                    else
                    {
                        path = path?.stringByAppendingString(dict["headImage"] as! String)
                        self.userImageView.image = getOvalInRect(UIImage.init(contentsOfFile: path!)!)
                    }
                    break;
                }
              }
          }
        

        
        
        let attributes = [NSFontAttributeName:UIFont.systemFontOfSize(16)]
        
        var attributedString1 = NSMutableAttributedString.init(string: _evalution.evalution!, attributes: attributes)
        
        _evaluetionLabel.attributedText = attributedString1
        var size = CGSizeMake(288,CGFloat.max)
        
        
        size = (_evalution.evalution! as NSString).boundingRectWithSize(size, options:NSStringDrawingOptions.UsesLineFragmentOrigin.exclusiveOr(NSStringDrawingOptions.UsesFontLeading), attributes: attributes, context: nil).size
        
        
        self.height = size.height+30
        
        
        let width = (UIScreen.mainScreen().bounds.size.width-40)/4
        self.imageHeight = CGFloat((self._evalution.images?.count)!/4+1)*width
        
        self.height = self.height! + self.imageHeight!
        
       
        
        for var i1:Int in 0..<5 {
            let buttons =  _starView.subviews as! Array<UIButton>
            
            if i1<Int.init(_evalution.star!)!
            {
                 buttons[i1].selected = true
            }
            else
            {
                 buttons[i1].selected = false
            }
        }
        
     }
    
    
    override func layoutSubviews() {
        self._headerViewTopView.snp_makeConstraints { (make) in
             make.top.right.left.equalTo(self)
             make.height.equalTo(1)
        }
        
        
        _headerView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self._headerViewTopView.snp_bottom)
            make.height.equalTo(28)
        }
        self._headerViewBottonView.snp_makeConstraints { (make) in
            make.right.left.equalTo(self._headerView)
            make.top.equalTo(self._headerView.snp_bottom)
            make.height.equalTo(1)
        }
        
       _evaluetionLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(self._headerViewBottonView.snp_bottom)
            make.height.equalTo(self.height!-30-self.imageHeight!)
        }
        _starView.snp_makeConstraints { (make) in
            make.top.bottom.right.equalTo(_headerView)
            make.width.equalTo(150)
        }
        self.userImageView.snp_makeConstraints { (make) in
            make.top.bottom.left.equalTo(_headerView)
            make.width.equalTo(self._headerView.snp_height)
        }
        _userLabel.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(_headerView)
            make.left.equalTo(self.userImageView.snp_right)
            make.width.equalTo(150)
        }
       self.viewForImageViews.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(self._evaluetionLabel.snp_bottom)
            make.height.equalTo(self.imageHeight!)
        }
    }
    
    override func didMoveToSuperview() {
        self.addSubview(self._headerViewTopView)
        self.addSubview(self._headerViewBottonView)
        self._headerViewBottonView.backgroundColor = UIColor.grayColor()
        self._headerViewTopView.backgroundColor = UIColor.grayColor()
        self._headerViewTopView.alpha = 0.5
        self._headerViewBottonView.alpha = 0.5
        _headerView.addSubview(_userLabel)
        _headerView.addSubview(_starView)
        self.addSubview(_headerView)
        self.addSubview(_evaluetionLabel)
        _evaluetionLabel.numberOfLines = 0
        self.addSubview(userImageView)
        self.addSubview(self.viewForImageViews)
    }
}

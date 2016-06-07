//
//  MYFirstPageCell.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/17.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

let cellID="MYFirstPageCell"
class MYFirstPageCell:UITableViewCell,CLLocationManagerDelegate{
    
   weak var _tableViewImageView: UIImageView?
   weak var _nameLabel: UILabel?
   weak var _one_wordLabel: UILabel?
   weak var _needMoneyLabel: UILabel?
   var _collectButton = UIButton()
   var _luckeyButton = UIButton()
   weak var _viewController:UIViewController?
   let lineGray = UIView()
   let distantLabel = UILabel()
    var _geocoder:CLGeocoder! = CLGeocoder()
   var _diffrentWithAgoModel:MYDiffrentWithAgoModel{
        set{
           self._diffrentWithAgoModelTmp = newValue
            
           self.setUpSubViewWithDiffrentWithAgoModel(newValue)
        }
        get
        {
           return _diffrentWithAgoModelTmp!
        }
    
    }
    lazy var _LM:CLLocationManager! = {
        
        let LM:CLLocationManager = CLLocationManager()
        LM.distanceFilter = 100
        if Float.init(UIDevice.currentDevice().systemVersion)>8.0
        {
            LM.requestAlwaysAuthorization()
        }
        return LM
    }()

    
    var _diffrentWithAgoModelTmp:MYDiffrentWithAgoModel?
    
    
    func setUpSubViewWithDiffrentWithAgoModel(diffrentWithAgoModel:MYDiffrentWithAgoModel) -> Void {
        
        
      
        _tableViewImageView?.image = UIImage(named: (diffrentWithAgoModel.picture!))
        _nameLabel?.text = diffrentWithAgoModel.name
        _nameLabel?.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
        
        
        
        
        let attributes:[String:AnyObject] = [NSFontAttributeName:UIFont.systemFontOfSize(14),NSForegroundColorAttributeName:UIColor.grayColor()]
        let attributeString = NSAttributedString.init(string:(diffrentWithAgoModel.oneWordToRecommend)! , attributes: attributes)
        
        _one_wordLabel?.attributedText = attributeString
        
        let attributes1:[String:AnyObject] = [NSFontAttributeName:UIFont.systemFontOfSize(10),NSForegroundColorAttributeName:UIColor.init(red: (CGFloat)(7*16+12)/256, green: (CGFloat)(12*16+13)/256, blue: (CGFloat)(7*16+12)/256, alpha: 1.0)]
        var attributedString1 = NSMutableAttributedString.init(string: "¥", attributes: attributes1)
        
        let attributes2:[String:AnyObject] = [NSFontAttributeName:UIFont.systemFontOfSize(20),NSForegroundColorAttributeName:UIColor.init(red: (CGFloat)(7*16+12)/256, green: (CGFloat)(12*16+13)/256, blue: (CGFloat)(7*16+12)/256, alpha: 1.0)]
        let attributeString2 = NSAttributedString.init(string:(diffrentWithAgoModel.money)! , attributes: attributes2)
        attributedString1.appendAttributedString(attributeString2)
        _needMoneyLabel?.attributedText = attributedString1
        
        
        self.distantLabel.textAlignment = NSTextAlignment.Right
        self.distantLabel.textColor = UIColor.orangeColor()
        
        
        self._LM.delegate = self
        self._LM.startUpdatingLocation()
        
    }
    
    
    
  static  func firstPageCellWithTableView(tableView:UITableView) -> MYFirstPageCell {
        
        
        var cell:MYFirstPageCell? = tableView.dequeueReusableCellWithIdentifier(cellID) as? MYFirstPageCell
    
        if cell == nil
        {
            
             cell = MYFirstPageCell(style: UITableViewCellStyle.Default , reuseIdentifier: cellID)
            
        }
        return cell!
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
       
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        
        self.contentView.addSubview(self.lineGray)
        lineGray.backgroundColor = UIColor.grayColor()
        lineGray.alpha = 0.5
        
        let tableViewImageView = UIImageView()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.contentView.addSubview(tableViewImageView)
        _tableViewImageView = tableViewImageView
        
        
        
        let nameLabel = UILabel()
        self.contentView.addSubview(nameLabel)
        _nameLabel = nameLabel
        
        
        let one_wordLabel = UILabel()
        self.contentView.addSubview(one_wordLabel)
        _one_wordLabel = one_wordLabel
        
        
        let needMoneyLabel = UILabel()
        self.contentView.addSubview(needMoneyLabel)
        _needMoneyLabel = needMoneyLabel
        
        self.contentView.addSubview(_collectButton)
        _collectButton.setImage(UIImage.init(named: "collect_none"), forState: UIControlState.Normal)
        _collectButton.setImage(UIImage.init(named: "collect"), forState: UIControlState.Selected)
        _collectButton.addTarget(self, action: #selector(collectButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.contentView.addSubview(_luckeyButton)
        _luckeyButton.setImage(UIImage.init(named: "turntable_none"), forState: UIControlState.Normal)
        _luckeyButton.setImage(UIImage.init(named: "turntable"), forState: UIControlState.Selected)
        _luckeyButton.addTarget(self, action: #selector(luckeyButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
       
        self.contentView.addSubview(self.distantLabel)
    }
    func collectButtonClick() -> Void {
        if MYMineModel._shareMineModel.name == nil
        {
            _loginClick(_viewController!)
            return
        }
        
        if _collectButton.selected == true {
            let path:String? = NSBundle.mainBundle().pathForResource("collect", ofType: "plist")
            var array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
            
            
            for var i1 in 0..<array!.count {
                var dict = array![i1]
                if dict["user"] as! String == MYMineModel._shareMineModel.name && dict["num"] as! String == _diffrentWithAgoModel.num
                {
                    array?.removeAtIndex(i1)
                    (
                        array as? NSArray)?.writeToFile(path!, atomically: true)
                    _collectButton.selected = false
                    return
                }
            }
        }
        else
        {
            let path:String? = NSBundle.mainBundle().pathForResource("collect", ofType: "plist")
            var array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
            let dict:[String:AnyObject] = ["name":(_diffrentWithAgoModel.name)!,"num":_diffrentWithAgoModel.num!,"picture":(_diffrentWithAgoModel.picture)!,"oneWordToRecommend":(_diffrentWithAgoModel.oneWordToRecommend)!,"user":MYMineModel._shareMineModel.name!]
            
            array?.append(dict)
            
            (array as? NSArray)?.writeToFile(path!, atomically: true)
            
            _collectButton.selected = true
            
        }

    }
    
    func luckeyButtonState() -> Void
    {
        let path:String? = NSBundle.mainBundle().pathForResource("lukeyScenic", ofType: "plist")
        var array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
        
        if array == nil || array?.count == 0
        {
            self._luckeyButton.selected = false
            return
        }
        
        for var i1 in 0..<array!.count {
            var dict = array![i1]
            if dict["num"] as! String == _diffrentWithAgoModel.num
            {
                self._luckeyButton.selected = true
                return
            }
        }
        self._luckeyButton.selected = false
        return
    }
    
    func collectButtonState() -> Void {
        
        let path:String? = NSBundle.mainBundle().pathForResource("collect", ofType: "plist")
        var array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
        
   
        for var i1 in 0..<array!.count {
            var dict = array![i1]
            if dict["user"] as! String == MYMineModel._shareMineModel.name && dict["num"] as! String == _diffrentWithAgoModel.num
            {
                _collectButton.selected = true
                return
            }
        }
        _collectButton.selected = false
        return

    }
    
    func luckeyButtonClick() -> Void {
        
        
           if _luckeyButton.selected == false
           {
            let path = NSBundle.mainBundle().pathForResource("lukeyScenic", ofType: "plist")
            var array:Array<[String:AnyObject]>? = (NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>)
            if array == nil
            {
                array = Array<[String:AnyObject]>()
            }
            
              if array!.count > 5
              {
                return;
               }
            let dict:[String:AnyObject] = ["num":_diffrentWithAgoModel.num!,"name":_diffrentWithAgoModel.name!,"picture":_diffrentWithAgoModel.picture!]
            array! .append(dict)
            (array as! NSArray) .writeToFile(path!, atomically: true)
            _luckeyButton.selected = !_luckeyButton.selected
           }
           else
           {
             let path = NSBundle.mainBundle().pathForResource("lukeyScenic", ofType: "plist")
             var array = NSArray.init(contentsOfFile: path!) as! Array<[String:AnyObject]>
            var index:Int = 0
            for var dict in array
            {
                if dict["num"] as! String == _diffrentWithAgoModel.num
                {
                    array.removeAtIndex(index)
                }
                index += 1
            }
            
            (array as! NSArray) .writeToFile(path!, atomically: true)
            _luckeyButton.selected = !_luckeyButton.selected
           }
        
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let startLocation:CLLocation = locations.first!
       
        
        _geocoder.geocodeAddressString(self._diffrentWithAgoModel.spot!) { (placeMarks:[CLPlacemark]?,error: NSError?) in
            if placeMarks == nil
            {
                return
            }
            let placemark :CLPlacemark = (placeMarks?.first!)!
           
            var distance:CLLocationDistance = startLocation.distanceFromLocation(placemark.location!)
            
            var distanceInt = Int.init(distance)
            distance = Double.init(distanceInt)
            
            if distance<1000.0
            {
                self.distantLabel.text = distance.description+"米"
            }
            else
            {
                distanceInt/=1000
                self.distantLabel.text = distanceInt.description+"千米"
               
            }
        }
        
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
           print("error")
    }
    
    
    
    override func layoutSubviews() {
        
        
        _tableViewImageView?.frame = CGRectMake(10, 10, self.frame.width * 0.25, self.frame.height - 20)
        
        self.lineGray.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.contentView)
            make.height.equalTo(1)
        }
        
        _nameLabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(_tableViewImageView!.snp_right).offset(10)
            make.top.equalTo(self.contentView.snp_top).offset(10)
            make.right.equalTo(self.contentView.snp_right).offset(-50)
            make.height.equalTo(self.contentView.snp_height).multipliedBy(0.25)
        })
        
        _one_wordLabel?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(_nameLabel!.snp_bottom).offset(10)
            make.right.equalTo(self.contentView.snp_right).offset(-10)
            make.left.equalTo(_tableViewImageView!.snp_right).offset(10)
            make.height.equalTo(self.snp_height).multipliedBy(0.25)
            
        })
        
        _needMoneyLabel?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(_one_wordLabel!.snp_bottom).offset(10)
            make.right.equalTo(self.contentView.snp_right).offset(-10)
            make.left.equalTo(_tableViewImageView!.snp_right).offset(10)
            make.height.equalTo(self.contentView.snp_height).multipliedBy(0.25)
            
        })
        
        _collectButton.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(10)
            make.height.equalTo((_nameLabel?.snp_height)!)
            make.right.equalTo(self.contentView)
            make.width.equalTo(25)
        }
        _luckeyButton.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(10)
            make.height.equalTo((_nameLabel?.snp_height)!)
            make.right.equalTo(_collectButton.snp_left)
            make.width.equalTo(25)
        }
        self.distantLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.contentView).offset(-10)
            make.right.equalTo(self.contentView).offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
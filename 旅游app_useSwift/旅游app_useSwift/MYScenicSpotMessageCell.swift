//
//  MYScenicSpotMessageCell.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/18.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


protocol  MYScenicSpotMessageCellDelegate{
    func scenicSpotMessageCell(scenicSpotMessageCell:MYScenicSpotMessageCell,phone:String)
    
}

class MYScenicSpotMessageCell: UITableViewCell,CLLocationManagerDelegate {
    
    let _nameLabel:UILabel = UILabel()
    let _spotLabel:UILabel = UILabel()
    let _distantLabel:UILabel = UILabel()
    let _phoneButton:UIButton = UIButton()
    var delete:MYScenicSpotMessageCellDelegate?
    var _geocoder:CLGeocoder! = CLGeocoder()
    var _startPlaceMark:CLPlacemark?
    var _endPlaceMaek:CLPlacemark?
    var _startLocation:CLLocation?
    var headLabel:UILabel = UILabel()
    var headLabelView:UIView = UIView()
    
    lazy var _LM:CLLocationManager! = {
      
        let LM:CLLocationManager = CLLocationManager()
        LM.distanceFilter = 100
        if Float.init(UIDevice.currentDevice().systemVersion)>8.0
        {
            LM.requestAlwaysAuthorization()
        }
        return LM
    }()
    let locationManager:CLLocationManager = CLLocationManager()
    
    var _spot:String!{
        set{
            _spotTmp = newValue
            _spotLabel.text = "地点："+newValue
            _spotLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
            
            self.setUpDistanLabelWithSpot(newValue)
        }
        get{
            return _spotTmp
        }
    }
    var _spotTmp:String?
    
    var _phoneNum:String!{
     
        set{
            _phoneNumTmp = newValue
            _phoneButton.addTarget(self, action:#selector(clickButton), forControlEvents: UIControlEvents.TouchUpInside)
        }
        get{
            return _phoneNumTmp
        }
    }
    var _phoneNumTmp:String?
    
    func setUpDistanLabelWithSpot(spot:String) -> Void {
        
         _LM.delegate = self
         _LM.delegate = self
         _LM .startUpdatingLocation()
        
        
    }
    
    func clickButton() -> Void {
          
         delete?.scenicSpotMessageCell(self, phone: _phoneNum)
    }
    
    static func scenicSpotMessageCellWithTableView(tableView:UITableView) -> MYScenicSpotMessageCell{
        let cellID = "MYScenicSpotMessageCell"
        
        var cell:MYScenicSpotMessageCell? = tableView.dequeueReusableCellWithIdentifier(cellID) as? MYScenicSpotMessageCell

        if cell == nil
        {
             cell = MYScenicSpotMessageCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellID)
        }
        
        return cell!
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    let _intervalView:UIView! = UIView()
    override func layoutSubviews() {
        _intervalView.snp_makeConstraints { (make) in
            
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(10)
        }
        self.headLabel.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(30)
        }
        self.headLabelView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.headLabel.snp_bottom)
            make.height.equalTo(1)
        }
        
        _nameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.headLabelView.snp_bottom)
            make.left.equalTo(self).offset(5)
            make.width.equalTo(self).multipliedBy(0.70)
            make.height.equalTo(self).multipliedBy(0.20)
        }
        _nameLabel.textColor = UIColor.redColor()
        _spotLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(_nameLabel)
            make.top.equalTo(_nameLabel.snp_bottom).offset(5)
            make.height.equalTo(_nameLabel)
        }
        _distantLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(_nameLabel)
            make.top.equalTo(_spotLabel.snp_bottom).offset(5)
            make.bottom.equalTo(self).offset(-5)
        }
       
        _phoneButton.snp_makeConstraints { (make) in
            make.left.equalTo(_nameLabel.snp_right).offset(10)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-20)
            make.top.equalTo(self.headLabel.snp_bottom).offset(10)
        }
    }
    
    override func didMoveToSuperview() {
        self.addSubview(_intervalView)
        self.addSubview(_nameLabel)
        self.addSubview(_spotLabel)
        self.addSubview(_distantLabel)
        self.addSubview(_phoneButton)
        self.addSubview(self.headLabel)
        self.addSubview(self.headLabelView)
        self.headLabel.text = "景点信息"
        self.headLabel.textColor = UIColor.grayColor()
        self.headLabelView.backgroundColor = UIColor.grayColor()
        self.headLabelView.alpha = 0.5
        _intervalView.backgroundColor = UIColor.grayColor()
        _phoneButton.backgroundColor = UIColor.redColor()
        _phoneButton.setTitle("打电话", forState: UIControlState.Normal)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        
        let startLocation:CLLocation = locations.first!
        _startLocation = startLocation
        print(_spot)
        _geocoder .geocodeAddressString(_spot) { (placeMarks:[CLPlacemark]?,error: NSError?) in
            
            
            if placeMarks == nil
            {
                return
            }
           
            let placemark :CLPlacemark = (placeMarks?.first!)!
            self._startPlaceMark = placemark
            var distance:CLLocationDistance = startLocation.distanceFromLocation(placemark.location!)
            
            var distanceInt = Int.init(distance)
            distance = Double.init(distanceInt)
            
            if distance<1000.0
            {
               self._distantLabel.text = "距离:"+distance.description+"米"
               self._distantLabel.textColor = UIColor.greenColor()
            }
            else
            {
               distanceInt/=1000
                self._distantLabel.text = "距离:"+distanceInt.description+"千米"
                self._distantLabel.textColor = UIColor.redColor()
            }
        }
        
        _distantLabel.addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
         _geocoder.reverseGeocodeLocation(_startLocation!) { (placeMarks:[CLPlacemark]?, error:NSError?) in
            
            if placeMarks == nil
            {   return
            }
            let placemark :CLPlacemark = (placeMarks?.first!)!
            self._endPlaceMaek = placemark
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
  
    }
    deinit{
        _distantLabel.removeObserver(self, forKeyPath: "text")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//
//  MYScenicSpotSetMealCell.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/18.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit


class MYScenicSpotSetMealCell: UITableViewCell {
    
    
    
    
    static func scenicSpotSetMealCellWithTableView(tableView:UITableView) -> MYScenicSpotSetMealCell{
        let cellID = "MYScenicSpotEvaluetionCell"
        
        var cell:MYScenicSpotSetMealCell? = tableView.dequeueReusableCellWithIdentifier(cellID) as? MYScenicSpotSetMealCell
        if cell == nil
        {
            cell = MYScenicSpotSetMealCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellID)
        }
        
        return cell!
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let _intervalView:UIView! = UIView()
    let _mealLabel:UILabel! = UILabel()
    let _contentLabel:UILabel! = UILabel()
    let _mealLabelView:UIView = UIView()
    override func layoutSubviews() {
        _intervalView.snp_makeConstraints { (make) in
            
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(10)
        }
        _mealLabel.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(30)
        }
        _mealLabelView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(_mealLabel.snp_bottom)
            make.height.equalTo(1)
        }
        _contentLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(20)
            make.right.equalTo(self.snp_right).offset(-20)
            make.top.equalTo(_mealLabel.snp_bottom).offset(10)
            make.bottom.equalTo(_intervalView.snp_top).offset(-10)
        }
        
    }
    
    override func didMoveToSuperview() {
        self.addSubview(_intervalView)
        self.addSubview(_mealLabel)
        self.addSubview(_contentLabel)
        self.addSubview(_mealLabelView)
        _mealLabelView.backgroundColor = UIColor.grayColor()
        _mealLabelView.alpha = 0.5
        _contentLabel.numberOfLines = 0
        _mealLabel.text = "每日套餐"
        _mealLabel.textColor = UIColor.grayColor()
        _intervalView.backgroundColor = UIColor.grayColor()
    }

}

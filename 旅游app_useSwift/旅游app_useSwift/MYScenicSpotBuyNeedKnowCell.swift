//
//  MYScenicSpotBuyNeedKnowCell.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/18.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit


class MYScenicSpotBuyNeedKnowCell: UITableViewCell {
    
    
    static func scenicSpotBuyNeedKnowCellWithTableView(tableView:UITableView) -> MYScenicSpotBuyNeedKnowCell{
        let cellID = "MYScenicSpotEvaluetionCell"
        
        var cell:MYScenicSpotBuyNeedKnowCell? = tableView.dequeueReusableCellWithIdentifier(cellID) as? MYScenicSpotBuyNeedKnowCell
        //        var cell:MYScenicSpotEvalutionCell? = tableView.dequeueReusableCellWithIdentifier("MYScenicSpotEvalutionCell") as? MYScenicSpotEvalutionCell
        if cell == nil
        {
            cell = MYScenicSpotBuyNeedKnowCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellID)
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
    let _buyNeedKnowLabel:UILabel! = UILabel()
    let _buyNeedKnowLabelView:UIView = UIView()
    let _contentLabel:UILabel! = UILabel()
    
    override func layoutSubviews() {
        _intervalView.snp_makeConstraints { (make) in
            
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(10)
        }
        _buyNeedKnowLabel.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(30)
        }
        _buyNeedKnowLabelView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(1)
            make.top.equalTo(_buyNeedKnowLabel.snp_bottom)
        }
        _contentLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(_buyNeedKnowLabelView.snp_bottom).offset(10)
            make.bottom.equalTo(_intervalView.snp_bottom).offset(-10)
        }
    }
    
    override func didMoveToSuperview() {
        self.addSubview(_intervalView)
        self.addSubview(_buyNeedKnowLabel)
        self.addSubview(_buyNeedKnowLabelView)
        _buyNeedKnowLabelView.backgroundColor = UIColor.grayColor()
        _buyNeedKnowLabelView.alpha = 0.5
        self.addSubview(_contentLabel)
        _contentLabel.numberOfLines = 0
        _buyNeedKnowLabel.text = "购买须知"
        _buyNeedKnowLabel.textColor = UIColor.grayColor()
        
        _intervalView.backgroundColor = UIColor.grayColor()
    }

}

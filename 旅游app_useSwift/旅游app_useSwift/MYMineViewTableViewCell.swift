//
//  MYMineViewTableViewCell.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/29.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYMineViewTableViewCell: UITableViewCell {

    
    static  func mineViewTableViewCellWithTableView(tableView:UITableView) -> MYMineViewTableViewCell {
        
        let cellID="MYMyticketCell"
        var cell:MYMineViewTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellID) as? MYMineViewTableViewCell
        
        if cell == nil
        {
            cell = MYMineViewTableViewCell(style: UITableViewCellStyle.Default , reuseIdentifier: cellID)
            
        }
        return cell!
    }
    let grayLine = UIView()
    let myImageView = UIImageView()
    let myLabel = UILabel()
    let indicationImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(grayLine)
        grayLine.backgroundColor = UIColor.grayColor()
        grayLine.alpha = 0.5
        self.contentView.addSubview(self.myImageView)
        self.contentView.addSubview(self.myLabel)
        self.contentView.addSubview(self.indicationImageView)
        self.indicationImageView.image = UIImage.init(named: "idication")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        self.grayLine.snp_makeConstraints { (make) in
            make.bottom.right.equalTo(self.contentView)
            make.left.equalTo(self.myLabel)
            make.height.equalTo(1)
        }
        self.myImageView.snp_makeConstraints { (make) in
            make.top.left.bottom.equalTo(self.contentView)
            make.width.equalTo(50)
        }
        self.myLabel.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.myImageView.snp_right)
            make.width.equalTo(100)
        }
        self.indicationImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.size.equalTo(CGSizeMake(20, 20))
        }
    }


}

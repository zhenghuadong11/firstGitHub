//
//  MYMineCollectCell.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/20.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//
import Foundation
import UIKit


class MYMineCollectCell:UITableViewCell  {
    
    weak var _tableViewImageView: UIImageView?
    weak var _nameLabel: UILabel?
    weak var _one_wordLabel: UILabel?
    weak var _needMoneyLabel: UILabel?
    
    var _collectModel:MYCollectModel{
        set{
            self._collectModelTmp = newValue
            self.setUpSubViewWithDiffrentWithAgoModel(newValue)
        }
        get
        {
            return _collectModelTmp!
        }
       
    }
    
    var _collectModelTmp:MYCollectModel?
    
    
    func setUpSubViewWithDiffrentWithAgoModel(diffrentWithAgoModel:MYCollectModel) -> Void {
        
        _tableViewImageView?.image = UIImage(named: (diffrentWithAgoModel.picture!))
        _nameLabel?.text = diffrentWithAgoModel.name
        _one_wordLabel?.text = diffrentWithAgoModel.oneWordToRecommend
        _needMoneyLabel?.text = diffrentWithAgoModel.money
    }
    
    
    
    static  func firstPageCellWithTableView(tableView:UITableView) -> MYMineCollectCell {
        
        let cellID="MYMineCollectCell"
        var cell:MYMineCollectCell? = tableView.dequeueReusableCellWithIdentifier(cellID) as? MYMineCollectCell
        if cell == nil
        {
            cell = MYMineCollectCell(style: UITableViewCellStyle.Default , reuseIdentifier: cellID)
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let tableViewImageView = UIImageView()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.addSubview(tableViewImageView)
        _tableViewImageView = tableViewImageView
        
        let nameLabel = UILabel()
        self.addSubview(nameLabel)
        _nameLabel = nameLabel
        
        let one_wordLabel = UILabel()
        self.addSubview(one_wordLabel)
        _one_wordLabel = one_wordLabel
        
        let needMoneyLabel = UILabel()
        self.addSubview(needMoneyLabel)
        _needMoneyLabel = needMoneyLabel
    }
    
    
    
    
    override func layoutSubviews() {
        
        
        _tableViewImageView?.frame = CGRectMake(10, 10, self.frame.width * 0.25, self.frame.height - 20)
        
        _nameLabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(_tableViewImageView!.snp_right).offset(10)
            make.top.equalTo(self.snp_top).offset(10)
            make.right.equalTo(self.snp_right).offset(-10)
            make.height.equalTo(self.snp_height).multipliedBy(0.25)
        })
        
        _one_wordLabel?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(_nameLabel!.snp_bottom).offset(10)
            make.right.equalTo(self.snp_right).offset(-10)
            make.left.equalTo(_tableViewImageView!.snp_right).offset(10)
            make.height.equalTo(self.snp_height).multipliedBy(0.25)
            
        })
        
        _needMoneyLabel?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(_one_wordLabel!.snp_bottom).offset(10)
            make.right.equalTo(self.snp_right).offset(-10)
            make.left.equalTo(_tableViewImageView!.snp_right).offset(10)
            make.height.equalTo(self.snp_height).multipliedBy(0.25)
            
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
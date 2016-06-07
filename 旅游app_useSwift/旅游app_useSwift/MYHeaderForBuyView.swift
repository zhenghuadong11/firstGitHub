//
//  MYHeaderForBuyView.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/18.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit


class MYHeaderForBuyView:UIView  {
    var _moneyLabel:UILabel = UILabel()
    var _buyButton:UIButton = UIButton()
    var _viewController:UIViewController?
    override func layoutSubviews() {
          _moneyLabel.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(self).multipliedBy(0.3)
        }
          _buyButton.snp_makeConstraints { (make) in
            make.top.right.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(self).multipliedBy(0.35)
        }
        
    }
    func buyButtonClick() -> Void {
        if MYMineModel._shareMineModel.name == nil
        {
              _loginClick(_viewController!)
            
        }
        if MYMineModel._shareMineModel.name == nil
        {
            return
        }
        
        MYZhifuModel.shareZhifuModel().user = MYMineModel._shareMineModel.name
        
        let zhifuDataViewController = MYZhifuDataSelectViewController()
        zhifuDataViewController.presentViewController = _viewController
        _viewController?.presentViewController(zhifuDataViewController, animated: true, completion: nil)
    }
    
    override func didMoveToSuperview() {
        self.addSubview(_moneyLabel)
        self.addSubview(_buyButton)
        _buyButton.addTarget(self, action: #selector(buyButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        _buyButton.backgroundColor = UIColor.orangeColor()
        _buyButton.setTitle("购买", forState: UIControlState.Normal)
    }
}

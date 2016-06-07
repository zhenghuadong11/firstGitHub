//
//  MYNewFeatureViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/16.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit

class MYNewFeatureViewController:  UIViewController{
    
    
    var _newFeatureScrollView:MYNewFeatureScrollView = MYNewFeatureScrollView()
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
      self.view.addSubview(_newFeatureScrollView)
       _newFeatureScrollView.createSubView()
      _newFeatureScrollView.snp_makeConstraints { (make) in
          make.top.left.right.bottom.equalTo(self.view)
        }
     
        
    }
    
}
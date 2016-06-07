//
//  MYVIEWForScrollView.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/17.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit

class MYVIEWForScrollView:UIView  {
    
   weak var _firstPageScrollView:MYFirstPageScrollView?
    
    func setUpScrollView() -> Void {
        let firstPageScrollView = MYFirstPageScrollView()
        _firstPageScrollView = firstPageScrollView
        self.addSubview(firstPageScrollView)
    }
    
    override func layoutSubviews() {
        self._firstPageScrollView?.frame = self.bounds
    }
    deinit{
    
    
       self._firstPageScrollView?._timer?.invalidate()
       self._firstPageScrollView?._timer = nil
    }
}

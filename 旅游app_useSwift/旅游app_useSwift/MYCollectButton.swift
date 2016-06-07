//
//  MYCollectButton.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/25.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYCollectButton: UIButton {

    static var button:MYCollectButton?
    static func shareCollectButton()->MYCollectButton
    {
         if button == nil
         {
             button = MYCollectButton()
         }
        return button!
    }

}

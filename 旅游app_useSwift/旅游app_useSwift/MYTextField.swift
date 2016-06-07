//
//  MYTextField.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/22.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

protocol MYTextFieldDelegate {
    func deleteBackward() -> Void
}

class MYTextField: UITextField {
    
    var keyInputDelegate:MYTextFieldDelegate?
    
    override func deleteBackward() {
        super.deleteBackward()
        if keyInputDelegate != nil {
            keyInputDelegate?.deleteBackward()
        }
        
        
    }
}

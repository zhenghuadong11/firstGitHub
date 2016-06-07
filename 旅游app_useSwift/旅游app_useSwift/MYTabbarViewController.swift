//
//  MYTabbarViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/17.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit

class MYTabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        
        
        let firstPageViewController:MYFirstPageViewController = MYFirstPageViewController()
        self.createSubViewController(firstPageViewController, imageName: "shouye.jpg", selectImageName: "shouye_selected.jpg", title: "首页")
       
        let scenicViewController:MYScenicViewController = MYScenicViewController()
        self.createSubViewController(scenicViewController, imageName: "jingdian", selectImageName: "jingdian", title: "景点")
        
        let mineViewController:MYMineViewController = MYMineViewController()
        self.createSubViewController(mineViewController, imageName: "wode", selectImageName: "wode", title: "我的")
        
        let  setupViewController:MYSetUpViewController = MYSetUpViewController()
        self.createSubViewController(setupViewController, imageName: "shezhi_select", selectImageName: "shezhi_select", title: "设置")

    }
    
    func createSubViewController(viewController:UIViewController, imageName:String, selectImageName:String, title:String) -> Void {
        
        let navigationController:UINavigationController = UINavigationController()
        navigationController.addChildViewController(viewController)
        
    
        var image = UIImage(named: imageName)
        
        var selectImage = UIImage(named: selectImageName)
        selectImage = selectImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.selectedImage = selectImage
        navigationController.tabBarItem.title = title
    
        self .addChildViewController(navigationController)
        
    }
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
      
             
    }
}
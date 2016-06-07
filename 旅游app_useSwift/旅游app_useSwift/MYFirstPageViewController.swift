//
//  MYFirstPageViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/17.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit

let scrollViewHeight:CGFloat = 200

class MYFirstPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
   weak var _tableView:UITableView?
   weak var _scrollView:MYVIEWForScrollView?
    
  var _recommendArrays:Array<MYRecommendModel>?
    
    var _diffrentWithAgoModels:Array<MYDiffrentWithAgoModel>?
    
    
func setUpRecommendArrays() ->Void{
            let path = NSBundle.mainBundle().pathForResource("recommend.plist", ofType: nil)
            if let _ = path
            {
                let array = NSArray(contentsOfFile:path!) as! Array<[String:AnyObject]>
                
                var dict:[String:AnyObject]
                
                var mArray:Array<MYRecommendModel> = Array<MYRecommendModel>()
                
                
                for var i1 in 0..<array.count  {
                    dict = array[i1]
                    let recommendModel = MYRecommendModel(dict: dict)
                    mArray.append(recommendModel)
                    
                }
               
                mArray.insert(mArray.last!, atIndex: 0)
                 mArray.append(mArray[1])
                _recommendArrays = mArray
                
            }
    
}
func setUpDiffrentWithAgoModels() -> Void {
        
        let path = NSBundle.mainBundle().pathForResource("diffrentWithAgo.plist", ofType: nil)
        
        
        if let _ = path
        {
            let array = NSArray(contentsOfFile:path!) as! Array<[String:AnyObject]>
            
            var dict:[String:AnyObject]
            
            var mArray:Array<MYDiffrentWithAgoModel> = Array<MYDiffrentWithAgoModel>()
            
            for var i1 in 0..<array.count  {
                dict = array[i1]
                let diffrentWithAgoModel = MYDiffrentWithAgoModel(dict: dict)
                mArray.append(diffrentWithAgoModel)
            }
            _diffrentWithAgoModels = mArray
            
        }
}

    
    override func viewDidLoad() {
        
        let titleLabel = UILabel()
        titleLabel.text = "首页"
        titleLabel.frame = CGRectMake(0, 0, 100, 30)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
       
        self.navigationItem.titleView = titleLabel
        
        
        super.viewDidLoad()
        self.setUpRecommendArrays()
        self.setUpDiffrentWithAgoModels()
        self.createTableView()
        
        self.navigationController?.navigationBar.barTintColor = MYRandColor()
        self.navigationController?.navigationBar.alpha = 0.3
 }
    
    func createTableView() -> Void {
        let tableView = UITableView()
        self.view .addSubview(tableView)
        _tableView = tableView
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.frame = CGRectMake(0,0, self.view.frame.width, self.view.frame.height)
    }
    
    
    func clickScrollView(sender :UITapGestureRecognizer) -> Void {
       let view =  sender.view as! MYVIEWForScrollView
       let num = Int((view._firstPageScrollView?.contentOffset.x)!/self.view.frame.width)
       let num1 = view._firstPageScrollView?._recommendArrays![num].num
       self.pushShowScenicSpotViewControllerWithNum(num1!)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        
        return self._diffrentWithAgoModels!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MYFirstPageCell = MYFirstPageCell.firstPageCellWithTableView(tableView)
       
        cell._viewController = self
        cell._diffrentWithAgoModel = self._diffrentWithAgoModels![indexPath.row]
        cell.collectButtonState()
        cell.luckeyButtonState()
        return cell
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if(section == 0)
        {
            
        let scrollView = MYVIEWForScrollView()
        _scrollView = scrollView
        scrollView.setUpScrollView()
       
      
        scrollView._firstPageScrollView!._recommendArrays = self._recommendArrays
        
        var tapGesture = UITapGestureRecognizer.init(target:self, action:#selector(clickScrollView))
        scrollView.addGestureRecognizer(tapGesture)
           
        return scrollView
        }
        else
        {
         var headerLabel = UILabel()
         headerLabel.text = "每日有不同"
         
         headerLabel.textColor = UIColor.whiteColor()
         headerLabel.backgroundColor = UIColor.init(red: (CGFloat)(7*16+12)/256, green: (CGFloat)(12*16+13)/256, blue: (CGFloat)(7*16+12)/256, alpha: 1.0)
            
         return headerLabel
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0
        {
           return scrollViewHeight
        }
        return 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let numString:String = _diffrentWithAgoModels![indexPath.row].num!
            self.pushShowScenicSpotViewControllerWithNum(numString)
    }
    
    
    
    func pushShowScenicSpotViewControllerWithNum(num:String) ->Void
    {
        let showScenicSpotViewController = MYScenicSpotShowViewController()
        
        showScenicSpotViewController._num = num
        showScenicSpotViewController._lastViewController = self
        self.navigationController?.pushViewController(showScenicSpotViewController, animated: true)
    }

    override func viewWillAppear(animated: Bool) {
        self._tableView?.reloadData()
    }

}



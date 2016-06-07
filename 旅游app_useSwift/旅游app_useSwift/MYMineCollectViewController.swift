//
//  MYMineCollectViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/20.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit



class MYMineCollectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    weak var _tableView:UITableView?
    var _collectModels:Array<MYCollectModel>?
    
    
    func setUpCollectModels() ->Void{
        let path = NSBundle.mainBundle().pathForResource("collect", ofType: "plist")
        
        if let _ = path
        {
            var array = NSArray(contentsOfFile:path!) as? Array<[String:AnyObject]>
            if array == nil {
              
                array = Array<[String:AnyObject]>()
            }
            var dict:[String:AnyObject]
            
            var mArray:Array<MYCollectModel> = Array<MYCollectModel>()
            

            for var i1 in 0..<array!.count  {
                dict = array![i1]
                let recommendModel = MYCollectModel(dict: dict)
                if recommendModel.user == MYMineModel._shareMineModel.name
                {
                    mArray.append(recommendModel)
                }
            }
            
            _collectModels = mArray
       
        }
        
    }
  
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setUpCollectModels()
        self.createTableView()
       
        
        
    }
    
    func createTableView() -> Void {
        let tableView = UITableView()
        self.view .addSubview(tableView)
        _tableView = tableView
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.frame = self.view.bounds
    }
    
    
  
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return self._collectModels!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MYMineCollectCell = MYMineCollectCell.firstPageCellWithTableView(tableView)
        
        cell._collectModel = self._collectModels![indexPath.row]
        
        return cell
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerLabel = UILabel()
        headerLabel.text = "我的收藏"
        headerLabel.backgroundColor = UIColor.greenColor()
        return headerLabel
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let numString:String = _collectModels![indexPath.row].num!
    
        self.pushShowScenicSpotViewControllerWithNum(numString)
        
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
                     
        let path:String? = NSBundle.mainBundle().pathForResource("collect", ofType: "plist")
        var array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
        
        
        for var i1 in 0..<array!.count {
            var dict = array![i1]
            if dict["user"] as! String == MYMineModel._shareMineModel.name && dict["num"] as! String == self._collectModels![indexPath.row].num
            {
                array?.removeAtIndex(i1)
                break
            }
            }
        (array! as NSArray) .writeToFile(path!, atomically: true)
        self._collectModels?.removeAtIndex(indexPath.row)
        self._tableView?.reloadData()
    }
    
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
    
               return UITableViewCellEditingStyle.Delete
    }
    
    
    func pushShowScenicSpotViewControllerWithNum(num:String) ->Void
    {
        let showScenicSpotViewController = MYScenicSpotShowViewController()
        
        showScenicSpotViewController._num = num
        
        self.navigationController?.pushViewController(showScenicSpotViewController, animated: true)
    }
    
    

    
    
}

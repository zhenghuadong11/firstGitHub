//
//  MYScenicViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/17.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//


import Foundation
import UIKit



class MYScenicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
    
    weak var _tableView:UITableView?
    var _searchTextField:UITextField?
    
    
    var _scenicSpotMessageModels:Array<MYScenicSpotMessageModel>?
    
    var _searchScenicSpotMessageModels:Array<MYScenicSpotMessageModel>?
    
    func setUpScenicSpotMessageModels() ->Void{
        let path = NSBundle.mainBundle().pathForResource("scenicSpotMessage.plist", ofType: nil)
        if let _ = path
        {
            let array = NSArray(contentsOfFile:path!) as! Array<[String:AnyObject]>
            
            var dict:[String:AnyObject]
            
            var mArray:Array<MYScenicSpotMessageModel> = Array<MYScenicSpotMessageModel>()
            
            
            for var i1 in 0..<array.count  {
                dict = array[i1]
                let recommendModel = MYScenicSpotMessageModel(dict: dict)
                mArray.append(recommendModel)
                
            }
            
            _scenicSpotMessageModels = mArray
            _searchScenicSpotMessageModels = mArray
            
        }
        
    }
    
    override func viewDidLoad() {
        
        let titleLabel = UILabel()
        titleLabel.text = "景点"
        titleLabel.frame = CGRectMake(0, 0, 100, 30)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
        
        self.navigationItem.titleView = titleLabel
        
       
        super.viewDidLoad()
        let searchTextField = UITextField()
        searchTextField.backgroundColor=UIColor.grayColor()
        let searchButton = UIButton()
        searchButton.setImage(UIImage.init(named: "search"), forState: UIControlState.Normal)
        searchButton.addTarget(self, action: #selector(searchButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        searchButton.frame = CGRectMake(0, 0, 30, 30)
        searchTextField.leftView = searchButton
        searchTextField.leftViewMode = UITextFieldViewMode.Always
        
        _searchTextField = searchTextField
        _searchTextField?.keyboardType = UIKeyboardType.Alphabet
        _searchTextField?.frame = CGRectMake(0, 0, 30, 30)
        let rightBarButtonItem = UIBarButtonItem.init(customView: _searchTextField!)
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        _searchTextField?.delegate = self
        _searchTextField?.placeholder = "输入景点名称"
        self.setUpScenicSpotMessageModels()
        self.createTableView()
    }
    
    func createTableView() -> Void {
        let tableView = UITableView()
        self.view .addSubview(tableView)
        _tableView = tableView
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
    }
    
    
    func searchButtonClick() -> Void {
          if _searchTextField?.frame.width > 50.0
         {
           UIView.animateWithDuration(1.5, animations: {
                self._searchTextField?.frame = CGRectMake(0, 0, 30, 30)
           })
            
         }
        else
          {
            UIView.animateWithDuration(1.5, animations: {
                self._searchTextField?.frame = CGRectMake(-150, 0, 150, 40)
            })
            
        }
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._searchScenicSpotMessageModels!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MYScenicViewCell = MYScenicViewCell.scenicViewCellWithTableView(tableView)
        cell._viewController = self
        cell._scenicSpotMessageModel = self._searchScenicSpotMessageModels![indexPath.row]
        cell.collectButtonState()
        cell.luckeyButtonState()
        return cell
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerLabel = UILabel()
        headerLabel.text = "所有景点"
        headerLabel.textColor = UIColor.whiteColor()
        headerLabel.backgroundColor = UIColor.init(red: (CGFloat)(7*16+12)/256, green: (CGFloat)(12*16+13)/256, blue: (CGFloat)(7*16+12)/256, alpha: 1.0)
        return headerLabel
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let numString:String = _searchScenicSpotMessageModels![indexPath.row].num!
        self.pushShowScenicSpotViewControllerWithNum(numString)
        
    }
    
    
    
    func pushShowScenicSpotViewControllerWithNum(num:String) ->Void
    {
        let showScenicSpotViewController = MYScenicSpotShowViewController()
        
        showScenicSpotViewController._num = num
        
        self.navigationController?.pushViewController(showScenicSpotViewController, animated: true)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var trueString = string
        var newString:String = textField.text!
        if ((textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)) <= range.location) {
            newString = newString + trueString
        }
        else
        {
            newString = (newString as! NSString).substringToIndex(range.location) as!String
        }
        if newString == ""
        {
         
            _searchScenicSpotMessageModels = _scenicSpotMessageModels
            
        }
        
        else
        {
       
        _searchScenicSpotMessageModels?.removeAll(keepCapacity: true)
        
        for var scenicSpotMessageModel:MYScenicSpotMessageModel in _scenicSpotMessageModels!
        {
            
            if scenicSpotMessageModel.name!.containsString(newString)
            {  _searchScenicSpotMessageModels?.append(scenicSpotMessageModel)
            }
        }
        
        }
        _tableView?.reloadData()
        return true
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        _searchTextField?.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
           return textField.resignFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
           self._tableView?.reloadData()
    }
    
    
}



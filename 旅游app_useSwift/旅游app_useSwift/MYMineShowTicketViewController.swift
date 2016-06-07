//
//  MYMineShowTicketViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/23.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

    import Foundation
    import UIKit
    

    
    class MYMineShowTicketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
        
        weak var _tableView:UITableView?
        var _segControl = UISegmentedControl.init(items: ["已领票","未领票"])
        
        var _myTicketModelArrays:Array<MYMyTicketModel>?
        var _myTicketHaveModels:Array<MYMYticketHaveModel>?
        
        
        func setUpmyTicketHaveModels() -> Void {
            
            let path = NSBundle.mainBundle().pathForResource("myPickerHave.plist", ofType: nil)
            
            if let _ = path
            {
                let array = NSArray(contentsOfFile:path!) as? Array<[String:AnyObject]>
                if array == nil
                {
                   _myTicketHaveModels = Array<MYMYticketHaveModel>()
                    return
                }
                
                
                var dict:[String:AnyObject]
                
                var mArray:Array<MYMYticketHaveModel> = Array<MYMYticketHaveModel>()
                
                for var i1 in 0..<array!.count  {
                    dict = array![i1]
                    let myTicketModel = MYMYticketHaveModel(dict: dict)
                 
                    if myTicketModel.user == MYMineModel._shareMineModel.name
                    {
                        mArray.append(myTicketModel)
                    }
                }
                _myTicketHaveModels = mArray
            
            }
        }
        func setUpmyTicketModelArrays() -> Void {
            
            let path = NSBundle.mainBundle().pathForResource("myPicker.plist", ofType: nil)
            
            
            if let _ = path
            {
                let array = NSArray(contentsOfFile:path!) as? Array<[String:AnyObject]>
                if array == nil
                {
                    _myTicketModelArrays = Array<MYMyTicketModel>()
                    return
                }
                
                
                var dict:[String:AnyObject]
                
                var mArray:Array<MYMyTicketModel> = Array<MYMyTicketModel>()
                
                for var i1 in 0..<array!.count  {
                    dict = array![i1]
                    let myTicketModel = MYMyTicketModel(dict: dict)
                 
                    if myTicketModel.user == MYMineModel._shareMineModel.name
                    {
                        mArray.append(myTicketModel)
                    }
                }
                _myTicketModelArrays = mArray
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.automaticallyAdjustsScrollViewInsets = false
            _segControl.selectedSegmentIndex = 1
            self.setUpmyTicketModelArrays()
            self.setUpmyTicketHaveModels()
            self.setUpSegControl()
            self.createTableView()
            
        }
        
        func setUpSegControl() -> Void
        {
           self.view.addSubview(_segControl)
            _segControl.addTarget(self,action:#selector(segControlClick), forControlEvents: UIControlEvents.ValueChanged)
            
           _segControl.frame = CGRectMake(0, 64, self.view.frame.width, 50)
        }
        
        func segControlClick() -> Void {
            
              _tableView?.reloadData()
        }
        
        func createTableView() -> Void {
            let tableView = UITableView()
            self.view .addSubview(tableView)
            _tableView = tableView
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            tableView.frame = CGRectMake(0,64+50, self.view.frame.width, self.view.frame.height - 64-50-44)
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if _segControl.selectedSegmentIndex == 0
            {
                
                  return (self._myTicketHaveModels?.count)!
            }
            
            return self._myTicketModelArrays!.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            
            if _segControl.selectedSegmentIndex == 0
            {
                let cell = MYMyticketHaveTableViewCell.firstPageCellWithTableView(tableView) as MYMyticketHaveTableViewCell
          
                
                 cell._myTicketModel = self._myTicketHaveModels![indexPath.row]
                
              if self._myTicketHaveModels![indexPath.row].isEvaluation == "true"
              {
                    cell._isHaveEvaluationLabel.text = "已评价"
              }
               else
              {
                    cell._isHaveEvaluationLabel.text = "未评价"
                }
                return cell
            }
             else
             {
              let cell = MYMyticketCell.firstPageCellWithTableView(tableView) as MYMyticketCell
              cell._myTicketModel = self._myTicketModelArrays![indexPath.row]
              return cell
              }
            return UITableViewCell()
        }
        
        
        func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
           
                var headerLabel = UILabel()
                if _segControl.selectedSegmentIndex == 0
                {
                    headerLabel.text = "已领门票－－未评价可以点击评价"
                }
                else
                {
                     headerLabel.text = "未领门票－－滑动退票"
                }
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
                 if _segControl.selectedSegmentIndex == 1
                 {
                          return
                 }
                 if _myTicketHaveModels![indexPath.row].isEvaluation == "true"
                 {
                         return
                 }
            
             let evaluationViewController =  MYEvaluationViewController()
             evaluationViewController._num = _myTicketHaveModels![indexPath.row].scenicNum
             evaluationViewController._myPickerHaveModel = _myTicketHaveModels![indexPath.row]
             evaluationViewController._evalutionIndex = indexPath.row
             evaluationViewController._viewController = self
            self.presentViewController(evaluationViewController, animated: true) { 
                
            }
        }
        
        
        func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            if _segControl.selectedSegmentIndex == 0
            {
                return
            }
            
                  let path = NSBundle.mainBundle().pathForResource("myPicker.plist", ofType: nil)
            var array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
            
            for var i1 in 0..<array!.count
            {
                let dict = array![i1]
                if (dict["num"] as! String) == _myTicketModelArrays![indexPath.row].num{
                      array?.removeAtIndex(i1)
                    break
                }
            }
            (array! as NSArray).writeToFile(path!, atomically: true)
            _myTicketModelArrays?.removeAtIndex(indexPath.row)
            _tableView?.reloadData()
            
        }
        
        
        func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
             if _segControl.selectedSegmentIndex == 0
             {
                  return UITableViewCellEditingStyle.None
             }
               return UITableViewCellEditingStyle.Delete
        }
        
        
}
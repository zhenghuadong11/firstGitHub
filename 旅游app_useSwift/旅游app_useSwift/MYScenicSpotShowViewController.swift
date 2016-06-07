//
//  MYScenicSpotShowViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/17.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class MYScenicSpotShowViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,MYScenicSpotMessageCellDelegate,UIWebViewDelegate {
    
    var _spotViewWidth:CGFloat = 0.0
    var _spotViewHeight:CGFloat = 0
    weak var _lastViewController:UIViewController?
    var _collectButton:UIButton?
    var _cell:MYScenicSpotEvaluetionCell?
    
    var _num:String{
        set{
            _numTmp = newValue
         
            self.setUpScenicSpotMessageModel()
            MYZhifuModel.shareZhifuModel().scenicNum = newValue
            
            
            let titleLabel = UILabel()
            titleLabel.text = self._scenicSpotMessageModel?.name
            titleLabel.frame = CGRectMake(0, 0, 100, 30)
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
            
            self.navigationItem.titleView = titleLabel
            
            
            
            MYZhifuModel.shareZhifuModel().name = _scenicSpotMessageModel?.name
            MYZhifuModel.shareZhifuModel().one_word = _scenicSpotMessageModel?.oneWordToRecommend
            MYZhifuModel.shareZhifuModel().picture = _scenicSpotMessageModel?.picture![0]
           
            
            MYZhifuModel.shareZhifuModel().money = _scenicSpotMessageModel?.money
            
            self.createAndSerUpSpotTableView()
            self.setUpCollectButton()
           }
        get{
        
         return _numTmp!
            }
    }
    var _numTmp:String?
    var _scenicSpotMessageModel:MYScenicSpotMessageModel?
    
    var _spotView = MYScenicSpotShowView()
    var _tableView = MYScenicSpotShowTableView()
    
    
    
    func setUpScenicSpotMessageModel() ->Void{
        
  
        let path = NSBundle.mainBundle().pathForResource("scenicSpotMessage.plist", ofType: nil)
    
        if let _ = path
        {
            let array = NSArray(contentsOfFile:path!) as! Array<[String:AnyObject]>
            var dict:[String:AnyObject]
            
            for var i1 in 0..<array.count  {
                dict = array[i1]
                let scenicSpotMessageModel = MYScenicSpotMessageModel(dict: dict)
                
               if scenicSpotMessageModel.num == _num
               {
                  _scenicSpotMessageModel = scenicSpotMessageModel
               }
                
            }
            
            
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
//        self.automaticallyAdjustsScrollViewInsets  = false
        let button = UIButton.init(type: UIButtonType.Custom)
        button.frame = CGRectMake(0, 0, 30, 30)
        button.setImage(UIImage.init(named: "share.jpg"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(shareToOther), forControlEvents: UIControlEvents.TouchUpInside)
        let barButton  = UIBarButtonItem.init(customView: button)
        
        let button1 = UIButton.init(type: UIButtonType.Custom)
        button1.frame = CGRectMake(0, 0, 30, 30)
        button1.setImage(UIImage.init(named: "collect_none.jpg"), forState: UIControlState.Normal)
        button1.setImage(UIImage.init(named: "collect.jpg"), forState: UIControlState.Selected)
        button1.addTarget(self, action: #selector(collectButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        _collectButton = button1
        
        
        let barButton1  = UIBarButtonItem.init(customView: button1)
        
        self.navigationItem.rightBarButtonItems = [barButton,barButton1]
        self.collectButtonState()
    }
    func shareToOther() -> Void {
       
        let shareView = MYShareView()
        shareView.viewController = self
        self.view.addSubview(shareView)
    
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
               return true
    }
    
    func setUpCollectButton() -> Void
    {
     
        if MYMineModel._shareMineModel.name == nil
        {
             return
        }
        
        let path:String? = NSBundle.mainBundle().pathForResource("collect", ofType: "plist")
        let array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
        
        for var dict in array! {
          
            if dict["user"] as! String == MYMineModel._shareMineModel.name && dict["num"] as! String == _num
            {
                   _collectButton?.selected = true
                   return
            }
        }
    }
    
    func collectButtonState() -> Void {
        
        let path:String? = NSBundle.mainBundle().pathForResource("collect", ofType: "plist")
        var array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
        
        
        for var i1 in 0..<array!.count {
            var dict = array![i1]
            if dict["user"] as! String == MYMineModel._shareMineModel.name && dict["num"] as! String == _num
            {
                _collectButton!.selected = true
                return
            }
        }
        _collectButton!.selected = false
        return
        
    }
    
    func collectButtonClick() -> Void {
        if MYMineModel._shareMineModel.name == nil
        {
             _loginClick(self)
            return
        }
        (self._lastViewController! as! MYFirstPageViewController)._tableView?.reloadData() //只有返回的时候reload一遍的
        if _collectButton?.selected == true {
            let path:String? = NSBundle.mainBundle().pathForResource("collect", ofType: "plist")
            var array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
            
            
            for var i1 in 0..<array!.count {
                var dict = array![i1]
                if dict["user"] as! String == MYMineModel._shareMineModel.name && dict["num"] as! String == _num
                {
                    array?.removeAtIndex(i1)
                    (
                    array as? NSArray)?.writeToFile(path!, atomically: true)
                    _collectButton?.selected = false
                    return
                }
            }
        }
        else
        {
            let path:String? = NSBundle.mainBundle().pathForResource("collect", ofType: "plist")
            var array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
        
           
            
            let dict:[String:AnyObject] = ["name":(_scenicSpotMessageModel?.name)!,"num":_num,"picture":(_scenicSpotMessageModel?.picture)!,"oneWordToRecommend":(_scenicSpotMessageModel?.oneWordToRecommend)!,"user":MYMineModel._shareMineModel.name!]
            
            array?.append(dict)
            
           (array as? NSArray)?.writeToFile(path!, atomically: true)
            
            _collectButton?.selected = true
            
        }
        
    }
    
    
    
        
        
        
    

    
    func createAndSerUpSpotTableView() -> Void {
        
         _tableView.delegate = self
        _tableView.dataSource = self
        
        self.view.addSubview(_tableView)
         _tableView.separatorStyle = UITableViewCellSeparatorStyle.None

        
        _tableView.frame = self.view.bounds
        

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 200
        }
        
        return 50
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {return 0
        }
        return 5
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 0)
        {
            _spotView.backgroundColor = MYRandColor()
            _spotView._imageNames = _scenicSpotMessageModel?.picture
            _spotView._one_word = _scenicSpotMessageModel?.oneWordToRecommend
            _spotView._name = _scenicSpotMessageModel?.name
            _spotViewHeight = 200
            return _spotView
        }
        
        let headView = MYHeaderForBuyView()
        headView._viewController = self
        let attributes1:[String:AnyObject] = [NSFontAttributeName:UIFont.systemFontOfSize(10),NSForegroundColorAttributeName:UIColor.init(red: (CGFloat)(7*16+12)/256, green: (CGFloat)(12*16+13)/256, blue: (CGFloat)(7*16+12)/256, alpha: 1.0)]
        var attributedString1 = NSMutableAttributedString.init(string: "¥", attributes: attributes1)
        
        let attributes2:[String:AnyObject] = [NSFontAttributeName:UIFont.systemFontOfSize(20),NSForegroundColorAttributeName:UIColor.init(red: (CGFloat)(7*16+12)/256, green: (CGFloat)(12*16+13)/256, blue: (CGFloat)(7*16+12)/256, alpha: 1.0)]
        let attributeString2 = NSAttributedString.init(string:(_scenicSpotMessageModel?.money)! , attributes: attributes2)
        attributedString1.appendAttributedString(attributeString2)
        
        
        headView._moneyLabel.attributedText = attributedString1
        headView.backgroundColor = MYRandColor()
        return headView
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell
        
        switch indexPath.row {
        case 0:
           let scenicSpotEvalutionCell = MYScenicSpotEvalutionCell.scenicSpotEvalutionCellWithTableView(tableView)
           scenicSpotEvalutionCell._num = _scenicSpotMessageModel?.num
           cell = scenicSpotEvalutionCell
        case 1:
            let scenicSpotMessageCell = MYScenicSpotMessageCell.scenicSpotMessageCellWithTableView(tableView)
            scenicSpotMessageCell._nameLabel.text = "景点:"+(_scenicSpotMessageModel?.name!)!
            scenicSpotMessageCell._nameLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
            scenicSpotMessageCell._phoneNum = _scenicSpotMessageModel?.phone!
            scenicSpotMessageCell._spot = (_scenicSpotMessageModel?.spot!)!
            scenicSpotMessageCell.delete = self
            cell = scenicSpotMessageCell
       
        case 2:
            let scenicSpotSetMealCell = MYScenicSpotSetMealCell.scenicSpotSetMealCellWithTableView(tableView)
            scenicSpotSetMealCell._contentLabel.text = _scenicSpotMessageModel?.setMeal
            scenicSpotSetMealCell._contentLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
            scenicSpotSetMealCell._contentLabel.font = UIFont.systemFontOfSize(14)
            cell = scenicSpotSetMealCell
            
        case 3:
            let scenicSpotBuyNeedKnowCell = MYScenicSpotBuyNeedKnowCell.scenicSpotBuyNeedKnowCellWithTableView(tableView)
            scenicSpotBuyNeedKnowCell._contentLabel.text = _scenicSpotMessageModel?.buyNeedKnow!
            scenicSpotBuyNeedKnowCell._contentLabel.textColor = UIColor.init(red: CGFloat(3*16+3)/256, green: CGFloat(3*16+3)/256, blue: CGFloat(3*16+3)/256, alpha: 1.0)
            scenicSpotBuyNeedKnowCell._contentLabel.font = UIFont.systemFontOfSize(14)
            cell = scenicSpotBuyNeedKnowCell
    
        default:
            let  scenicSpotEvaluetionCell = MYScenicSpotEvaluetionCell.scenicSpotEvaluetionCellWithTableView(tableView)
  

            scenicSpotEvaluetionCell._num = (_scenicSpotMessageModel?.num!)!
            _cell = scenicSpotEvaluetionCell
            cell = scenicSpotEvaluetionCell
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if(indexPath.row == 1)
        {
            let cell:MYScenicSpotMessageCell = tableView.cellForRowAtIndexPath(indexPath) as! MYScenicSpotMessageCell
            if cell._startPlaceMark != nil && cell._endPlaceMaek != nil
            {
                 let mapShowViewController = MYMapShowViewController()
                 mapShowViewController.setUpStartAndEndPlaceMark(cell._startPlaceMark!, endPlaceMark: cell._endPlaceMaek!)
                 self.navigationController!.pushViewController(mapShowViewController, animated: true)
            }
        }
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       
        
        switch indexPath.row {
        case 0:
         
             return 60
            
        case 1:
            
              return 142
        case 2:
            var size:CGSize = CGSizeMake(self.view.frame.width-40, CGFloat.max)
            
            let attributes = [NSFontAttributeName:UIFont.systemFontOfSize(14)]
            
            size = ((_scenicSpotMessageModel?.setMeal)! as NSString).boundingRectWithSize(size, options:NSStringDrawingOptions.UsesLineFragmentOrigin.exclusiveOr(NSStringDrawingOptions.UsesFontLeading), attributes: attributes, context: nil).size
           
            return size.height+61
          
        case 3:
            var size:CGSize = CGSizeMake(self.view.frame.width-40, CGFloat.max)
            
            let attributes = [NSFontAttributeName:UIFont.systemFontOfSize(14)]
            
            size = ((_scenicSpotMessageModel?.buyNeedKnow)! as NSString).boundingRectWithSize(size, options:NSStringDrawingOptions.UsesLineFragmentOrigin.exclusiveOr(NSStringDrawingOptions.UsesFontLeading), attributes: attributes, context: nil).size
          
                return size.height+61
            
           
        default:
            if _cell != nil
            {
               return _cell!.height
                
            }
            
            return 210
        }
    }
    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//    
//        
////        if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < (scrollViewHeight+5)
////        {
////            _spotView.transform = CGAffineTransformMakeTranslation(0, -scrollView.contentOffset.y)
////            _tableView.transform = CGAffineTransformMakeTranslation(0, -scrollView.contentOffset.y)
////            
////        }
//        if scrollView.contentOffset.y <= 0
//        {
//            let scale:CGFloat = -CGFloat(scrollView.contentOffset.y / _spotView.frame.height)
////
//            _spotView.layer.anchorPoint = CGPointMake(0.5, 0)
//            _spotView.layer.position = CGPointMake(_spotViewWidth/2, 64)
//            _spotView.layer.transform = CATransform3DMakeScale(1+scale, 1+scale, 1)
//            
////            _spotView.frame.size.height = 100
////            _spotView.frame.size.width = _spotViewWidth * (1-scrollView.contentOffset.y/_spotViewHeight)
//            
//        }
//    }
    
    func scenicSpotMessageCell(scenicSpotMessageCell: MYScenicSpotMessageCell, phone: String) {
        
        
        let urlString:String = "tel:" + phone
        let callWebView:UIWebView = UIWebView()
        let request:NSURLRequest = NSURLRequest.init(URL: NSURL.fileURLWithPath(urlString))
        callWebView.loadRequest(request)
        callWebView.frame = self.view.bounds
        self.view.addSubview(callWebView)
        
    }
    
}





//
//  MYScenicSpotEvaluetionCell.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/18.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit


class MYScenicSpotEvaluetionCell: UITableViewCell {
    
    let headLabel = UILabel()
    let headLabelView = UIView()
    var height:CGFloat = 30
    
    var _num:String{
        set{
            _numTmp = newValue
            createAndSetUpScenicSpotEvaluetionModels(newValue)
            createAndSetUpEvalutionViews()
        }
        get
        {
            return _numTmp!
        }
    }
    
    var _numTmp:String?
    var evalutionViews:Array<MYScenicSpotEvaluetionView> = Array<MYScenicSpotEvaluetionView>()
    
    var _scenicSpotEvaluetionModels:Array<MYScenicSpotEvaluetionModel> = Array<MYScenicSpotEvaluetionModel>()
    
    
    func createAndSetUpEvalutionViews() -> Void {
        self.height = 30
        for var i1 in 0..<evalutionViews.count {
            
            
            evalutionViews[i1]._evalution = _scenicSpotEvaluetionModels[i1]
            self.height += self.evalutionViews[i1].height!
                    }
        for var i2 in evalutionViews.count..<_scenicSpotEvaluetionModels.count{
             let evalutionView = MYScenicSpotEvaluetionView()
             evalutionView._evalution = _scenicSpotEvaluetionModels[i2]
             print(evalutionView._evalution)
             self.height += evalutionView.height!
             evalutionViews.append(evalutionView)
             self.addSubview(evalutionView)
        }
        print(self.height)
    }
    
    func createAndSetUpScenicSpotEvaluetionModels(num:String) -> Void {
        
            var array = getArrayFromPlist("evaluetion.plist")
           
            var mArrayTmp = Array<MYScenicSpotEvaluetionModel>()
        for var dict in array {
            
            if dict["num"] as! String == num
            {
                let scenicSpotEvaluetionModel:MYScenicSpotEvaluetionModel = MYScenicSpotEvaluetionModel.scenicSpotEvaluetionModelWithDict(dict)
                mArrayTmp.append(scenicSpotEvaluetionModel)
            }
        }
        _scenicSpotEvaluetionModels = mArrayTmp
    }
    
    static func scenicSpotEvaluetionCellWithTableView(tableView:UITableView) -> MYScenicSpotEvaluetionCell{
        let cellID = "MYScenicSpotEvaluetionCell"
        
        var cell:MYScenicSpotEvaluetionCell? = tableView.dequeueReusableCellWithIdentifier(cellID) as? MYScenicSpotEvaluetionCell
        if cell == nil
        {
            cell = MYScenicSpotEvaluetionCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellID)
        }
        
        return cell!
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func layoutSubviews() {
        
        
        
        self.headLabel.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(30)
        }
        
   
        var totalHeight:CGFloat = 30
        for var i1 in 0..<self.subviews.count
        {
             if !self.subviews[i1].isKindOfClass(MYScenicSpotEvaluetionView)
             {     continue;
             }
             let evaluetionView = self.subviews[i1] as! MYScenicSpotEvaluetionView
            
            self.subviews[i1].frame = CGRectMake(0,totalHeight , self.frame.width, 200)
            totalHeight += evaluetionView.height!
        }
    }
    
    override func didMoveToSuperview() {
       
        self.addSubview(headLabel)
        let attributes = [NSFontAttributeName:UIFont.init(name: "Bodoni 72", size: 15)!,NSForegroundColorAttributeName:UIColor.redColor()]
        let attributeString = NSAttributedString.init(string: "评价", attributes: attributes)
        
        self.headLabel.attributedText = attributeString
    }

}

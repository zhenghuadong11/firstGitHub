//
//  MYNewFeatureScrollView.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/16.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit






class MYFirstPageScrollView: UIScrollView,UIScrollViewDelegate {
    
    weak var _pageControl:UIPageControl?
    weak var _nameLabel:UILabel?
    weak var _recommendLabel:UILabel?
    weak var _timer:NSTimer?
    var i = 0;
    var scrollKey:Bool=false
    var _recommendArrays:Array<MYRecommendModel>?{
        
        
        set
        {
            
          
            self.__recommendArraysTmp = newValue
            [self .createImageViewWithRecommendArrays(newValue)]
        }
        
        get
        {
            return self.__recommendArraysTmp
        }
    }
    
    var __recommendArraysTmp:Array<MYRecommendModel>?
    
    
    func createImageViewWithRecommendArrays(recommendArrays:Array<MYRecommendModel>?) -> Void {
        
   
     
        
        
        if recommendArrays == nil {
            return;
        }
        
        self.pagingEnabled = true
        self.delegate = self
        
     
        if(_pageControl == nil)
        {
            let pageControl:UIPageControl = UIPageControl()
          
            
            pageControl.numberOfPages = _recommendArrays!.count-2
            pageControl.pageIndicatorTintColor = UIColor.grayColor()
            pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
            
            pageControl.currentPage = 0
            _pageControl = pageControl
            self.superview!.addSubview(pageControl)
        }
        
        
        
        
        
        var index:Int = 0
        var view:UIView
        for view in self.subviews {
            if !view.isKindOfClass(MYRecommendView)
            {continue
            }
            let recommendView:MYRecommendView = view as! MYRecommendView
            
            if(index < recommendArrays?.count)
            {
                recommendView._recommendModel = recommendArrays![index]
                recommendView.hidden = false
            }
            else
            {
                recommendView.hidden = true
            }
            index += 1
            
        }
        
        
        
        for ;index < recommendArrays?.count; index+=1 {
            
            var recommendView:MYRecommendView = MYRecommendView()
            recommendView.backgroundColor = MYRandColor()
            
            recommendView._recommendModel = recommendArrays![index]
            
            self.addSubview(recommendView)
        }
         self.contentSize = CGSizeMake(self.frame.width * CGFloat(_recommendArrays!.count), self.frame.height)
        
        
      
        if _timer == nil {
            _timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(timerClick), userInfo: nil, repeats: true)
        }

    }
    
    func timerClick() -> Void {
    
     
        if self.contentOffset.x == CGFloat(_recommendArrays!.count-2)*self.frame.width
        {
            
            self.scrollKey = true
            self.contentOffset.x = 0
            
        }
       
        
        UIView.animateWithDuration(0.6) {
            self.contentOffset.x += self.frame.width
        }
        self.setUpPage()
        
    }
    
    override func layoutSubviews() {
     
         super.layoutSubviews()
    
        if _recommendArrays == nil
        {
            return;
        }
        self.contentSize = CGSizeMake(self.frame.width * CGFloat(_recommendArrays!.count), self.frame.height)

        if i<2
        {
            i++;
            if i>3
            {
                i=4;
            }
            self.contentOffset.x = self.frame.width
        }
        
       
        
        var index:Int = 0
        
        for var view:UIView in self.subviews {
            if !view.isKindOfClass(MYRecommendView)
            {continue
            }
            
            view.frame = CGRectMake(CGFloat(index) * self.frame.width,0,self.frame.width,self.frame.height)
            index += 1
        }
        
        
        
        _pageControl?.snp_makeConstraints(closure: { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(50)
            make.top.equalTo(self.snp_top).offset(self.frame.height-50)
        })
        
    }
    
    
    
    func buttonClick() -> Void {
        
        UIApplication.sharedApplication().keyWindow?.rootViewController = ViewController()
        
    }

    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if _timer != nil && self.scrollKey == true
        {
            return
        }
        
        if scrollView.contentOffset.x >= CGFloat(_recommendArrays!.count-1)*self.frame.width
        {
            scrollView.contentOffset.x = self.frame.width;
        }

        if scrollView.contentOffset.x <= 0
        {
            scrollView.contentOffset.x = CGFloat(_recommendArrays!.count-2)*self.frame.width
        }
        self.setUpPage()

        
    }
    func setUpPage()->Void
    {
        let currentPage:Int = Int((self.contentOffset.x + self.frame.width/2) / (self.frame.width))
        
        
        var realCurrentPage:Int = 0
        if currentPage == 0
        {
            realCurrentPage = _recommendArrays!.count-3
            
        }
        else if currentPage == _recommendArrays!.count-1
        {
            realCurrentPage = 0
        }
        else
        {
            realCurrentPage = currentPage-1
        }
        _pageControl?.currentPage = realCurrentPage
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        _timer?.invalidate()
        _timer = nil
    }
    
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        _timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(timerClick), userInfo: nil, repeats: true)
        self.scrollKey = false
    }
    
    deinit{
  

       _timer?.invalidate()
       _timer = nil
    }
    
}
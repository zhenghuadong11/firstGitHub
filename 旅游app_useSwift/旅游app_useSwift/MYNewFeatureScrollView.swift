//
//  MYNewFeatureScrollView.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/16.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit






class MYNewFeatureScrollView: UIScrollView,UIScrollViewDelegate {
    
    weak var _inputButton:UIButton?
    weak var _pageControl:UIPageControl?
    
    weak var _useMapView:UIView?
    weak var _ticketManager:UIView?
    weak var _turnTable:UIView?
    weak var _imageView:UIImageView?
   
    func createSubView()-> Void {
        
       
        
        self.pagingEnabled = true
        self.delegate = self
        
        if(_inputButton == nil)
        {
            let button:UIButton = UIButton()
            
            button.setTitle("宜州欢迎您", forState: UIControlState.Normal)
            button.titleLabel?.textColor = UIColor.blueColor()
            self .addSubview(button)
            _inputButton = button
            button.addTarget(self, action:#selector(MYNewFeatureScrollView.buttonClick) , forControlEvents: UIControlEvents.TouchUpInside)
        }
        if(_pageControl == nil)
        {
            let pageControl:UIPageControl = UIPageControl()
      
            
            pageControl.numberOfPages = 4
            pageControl.pageIndicatorTintColor = UIColor.grayColor()
            pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
            
            _pageControl = pageControl
            self.superview!.addSubview(pageControl)
        }
        
  
        let useMapView = NSBundle.mainBundle().loadNibNamed("MYNewFeature_UseMap", owner: nil, options: nil).first as! MYNewFeature_UseMap
        
        self.addSubview(useMapView)
        _useMapView = useMapView
        
        let ticketManager = NSBundle.mainBundle().loadNibNamed("MYNewFeature_ticketManager", owner: nil, options: nil).first as! MYNewFeature_ticketManager
        
        self.addSubview(ticketManager)
        _ticketManager = ticketManager
    
        let turnTable = NSBundle.mainBundle().loadNibNamed("MYNewFeature_turntable", owner: nil, options: nil).first as! MYNewFeature_turntable
        
        self.addSubview(turnTable)
        _turnTable = turnTable
        
       let imageView = UIImageView()
        imageView.image = UIImage.init(named: "newfeature_image")
       self.addSubview(imageView)
       _imageView = imageView
        
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentSize = CGSizeMake(4*self.frame.width, self.frame.height)
        
        var index:Int = 0
        
         _useMapView!.frame = self.bounds
         _ticketManager!.frame = CGRectMake(self.frame.width, 0, self.frame.width,self.frame.height)
         _turnTable!.frame = CGRectMake(self.frame.width*2, 0, self.frame.width, self.frame.height)
        _imageView!.frame = CGRectMake(self.frame.width*3, 0, self.frame.width, self.frame.height)
        
        
        self.bringSubviewToFront(_inputButton!)
        
        _inputButton?.snp_makeConstraints(closure: { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.bottom.equalTo(self.snp_top).offset(self.frame.height - 100)
            
            var t = 4
            t -= 1;
            
            var offset = (CGFloat(t) * self.frame.width)
            offset += self.frame.width/2
            
            make.left.equalTo(self).offset(offset - 50)
            
          })
        
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
       
        let currentPage:Int = Int((self.contentOffset.x + self.frame.width/2) / (self.frame.width))
        
        _pageControl?.currentPage = currentPage
    }
    
    
    
}
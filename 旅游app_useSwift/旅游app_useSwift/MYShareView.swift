
//
//  MYShareView.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/5/30.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYShareView: UIView,UIWebViewDelegate{

    let sinaButton = UIButton()
    let moreButton = UIButton()
    let mengban = UIView()
    weak var viewController:UIViewController?
   
    

   
    override func didMoveToSuperview() {
        self.frame = UIScreen.mainScreen().bounds
        self.mengban.frame = UIScreen.mainScreen().bounds
        self.mengban.backgroundColor = UIColor.grayColor()
        self.mengban.alpha = 0.5
        self.addSubview(self.mengban)
        self.addSubview(sinaButton)
        self.addSubview(moreButton)
        sinaButton.frame = CGRectMake(self.frame.width/2-50,150 , 50, 50)
        moreButton.frame = CGRectMake(self.frame.width/2, 150, 50, 50)
        sinaButton.addTarget(self, action:#selector(sinaButtonClick) , forControlEvents: UIControlEvents.TouchUpInside)
        moreButton.addTarget(self, action:#selector(moreButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        sinaButton.setBackgroundImage(UIImage.init(named: "sinaShare"), forState: UIControlState.Normal)
        moreButton.setBackgroundImage(UIImage.init(named: "moreShare"), forState: UIControlState.Normal)
    }
    func sinaButtonClick() -> Void {
        var webView = UIWebView.init()
        webView.frame = self.bounds;
        self.addSubview(webView)
        
        // 2.加载登录页面
        var urlStr = "https://api.weibo.com/oauth2/authorize?client_id="+shareAppjey+"&redirect_uri="+shareUri
        
        var url = NSURL.init(string: urlStr)
        
        var request = NSURLRequest.init(URL: url!)
        
        webView.loadRequest(request)
        
        // 3.设置代理
        webView.delegate = self;
    }
    func moreButtonClick() -> Void {
                UMSocialData.setAppKey(appkey)
                let shareText = "让朋友们都知道它的美"
                let image = UIImage.init(named: "share.png")
                let snsNames = [UMShareToDouban,UMShareToEmail,UMShareToRenren,UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline]
                UMSocialSnsService.presentSnsIconSheetView(viewController, appKey: appkey, shareText: shareText, shareImage: image, shareToSnsNames: snsNames, delegate: nil)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
          self.removeFromSuperview()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        let url = request.URL?.absoluteString
//        let range = url?.rangeOfString("code=")
//        let code = url?.substringWithRange(range!)
//        print(code)
//        self.sccessTokeWithCode(code!)
        return false
        // 2.判断是否为回调地址
      
    }
//    func sccessTokeWithCode(code:String) -> Void {
//       var mgr = AFHTTPRequestOperationManager.init()
//        var params = ["client_id":shareAppjey,"client_secret":shareAppSecret,"grant_type":"authorization_code"]
//       
//    }
    
}

//
//  MYHeadImageSendViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/30.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

class MYHeadImageSendViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MYDrawingBoardViewControllerDelegate {
    
    var imageName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
   
    @IBOutlet weak var imageView: UIImageView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    @IBAction func albumSendClick(sender: AnyObject) {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        {  return
        }
        let ipc = UIImagePickerController.init()
        ipc.delegate = self
        self.presentViewController(ipc, animated: true, completion: nil)
    }
    @IBAction func camelSendClick(sender: AnyObject) {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
             return
        }
        let ipc = UIImagePickerController.init()
        ipc.sourceType = UIImagePickerControllerSourceType.Camera
        ipc.delegate = self
        self.presentViewController(ipc, animated: true, completion: nil)
    }
   
    @IBAction func selfSendClick(sender: AnyObject) {
        
          let drawViewController = MYDrawingBoardViewController()
          drawViewController.delegate = self
          self.presentViewController(drawViewController, animated: true, completion: nil)
    }
    
    @IBAction func sendToHeadImage(sender: AnyObject) {
        
        if self.imageView.image == nil
        {
            self.imageView.image = getOvalInRect(UIImage.init(named: "none_login")!)
        }
        
        
        MYMineModel._shareMineModel.image = self.imageView.image
        
        MYMineModel._shareMineModel.headImageButton.setImage(self.imageView.image, forState: UIControlState.Normal)
        let path = NSBundle.mainBundle().pathForResource("user.plist", ofType: nil)
        var array = NSArray.init(contentsOfFile: path!) as? Array<[String:AnyObject]>
        let r = rand()%10000
        self.imageName = getCurrentTime()+r.description+".png"
       
        
        for var i1 in 0..<array!.count
        {
             if (array![i1]["name"] as! String) == MYMineModel._shareMineModel.name
             {
                  array![i1]["headImage"] = self.imageName!
                  break
             }
        }
        (array as! NSArray).writeToFile(path!, atomically: true)
        
        
       
        
        var path1 = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        
        path1 = path1?.stringByAppendingString("/ImageFile")
        var fileManager = NSFileManager.defaultManager()
        
        if  fileManager.fileExistsAtPath(path1!) == false
        {
            do{
                try? fileManager.createDirectoryAtPath(path1!, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error as NSError
            {
                print("文件夹生成错误")
            }
        }
        path1 = path1?.stringByAppendingString("/"+self.imageName!)
        
        
        do{
            try? UIImagePNGRepresentation(self.imageView.image!)?.writeToFile(path1!, options: NSDataWritingOptions.AtomicWrite)
        }
        catch let error as NSError
        {
            print("文件夹生成错误")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = getOvalInRect(image)
    }
    func drawingBoardViewController(drawViewController: MYDrawingBoardViewController, image: UIImage) {
        self.imageView.image = getOvalInRect(image)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

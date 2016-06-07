//
//  MYDrawingBoardViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/30.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit

protocol MYDrawingBoardViewControllerDelegate {
    func drawingBoardViewController(drawViewController:MYDrawingBoardViewController,image:UIImage) -> Void
}

class MYDrawingBoardViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var delegate:MYDrawingBoardViewControllerDelegate?
    
    @IBOutlet weak var boardView: MYBoardView!
   
    
    @IBOutlet weak var lineSlider: UISlider!
    
    @IBOutlet weak var xiangpiSlide: UISlider!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineSlider.value = 0
        xiangpiSlide.value = 0
        
     
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func setUpDrawingView(image:UIImage) -> Void {
         let drawImageView = MYDrawImageView()
         drawImageView.frame = CGRectMake(0, 0, 50,50)
        
         self.boardView.addSubview(drawImageView)
        drawImageView.userInteractionEnabled = true
        drawImageView.image = image
        let pinchGesture =  UIPinchGestureRecognizer.init(target: self, action: #selector(drawImageViewPinchGestue))
        drawImageView.addGestureRecognizer(pinchGesture)
        let tagGesture = UITapGestureRecognizer.init(target: self, action: #selector(drawImagetagGesture))

        drawImageView.addGestureRecognizer(tagGesture)
    }
    
    func drawImageViewPinchGestue(pin:UIPinchGestureRecognizer) -> Void {
       
            let view = pin.view
            view?.transform = CGAffineTransformMakeScale(pin.scale, pin.scale)
        
    }
    
    func drawImagetagGesture(tag:UITapGestureRecognizer) -> Void {
        
        
        
    }
    
    @IBAction func greenButtonClick(sender: UIButton) {
        self.boardView.currentColor = sender.backgroundColor!
        self.boardView.colorType = 1
        self.lineSlideClick(self.lineSlider)
    }

    @IBAction func blackButtonClick(sender: AnyObject) {
        self.boardView.currentColor = UIColor.blackColor()
        self.boardView.colorType = 1
        self.lineSlideClick(self.lineSlider)
    }
    @IBAction func skyblueButtonClick(sender: UIButton) {
        
        self.boardView.currentColor = sender.backgroundColor!
        self.boardView.colorType = 1
        self.lineSlideClick(self.lineSlider)
    }
    
    @IBAction func blueButtonClick(sender: UIButton) {
        self.boardView.currentColor = sender.backgroundColor!
        self.boardView.colorType = 1
        self.lineSlideClick(self.lineSlider)
    }
    
    @IBAction func redButtonClick(sender: UIButton) {
        self.boardView.currentColor = sender.backgroundColor!
        self.boardView.colorType = 1
        self.lineSlideClick(self.lineSlider)
    }
    
    @IBAction func pickButtonClick(sender: UIButton) {
        self.boardView.currentColor = sender.backgroundColor!
        self.boardView.colorType = 1
        self.lineSlideClick(self.lineSlider)
    }
    
    
    
    @IBAction func lineSlideClick(sender: AnyObject) {
          if self.boardView.colorType == 2
          {
              return
          }
          self.boardView.currentLineSize = CGFloat((lineSlider.value*20)+1)
    }
    @IBAction func xiangpiSlideClick(sender: AnyObject) {
          if self.boardView.colorType == 1
          {
               return
          }
          self.boardView.currentLineSize = CGFloat(self.xiangpiSlide.value*40)+1
          
    }
    @IBAction func finishButtonClick(sender: AnyObject) {
        
        self.delegate?.drawingBoardViewController(self, image: imageWithView(self.boardView))
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func imageWithView(view:UIView) -> UIImage {
         UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 1)
         let ctx = UIGraphicsGetCurrentContext()
         view.layer .renderInContext(ctx!)
         let image = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         return image
    }
    
    
    @IBAction func xiangpiButtonClick(sender: AnyObject) {
          self.boardView.currentColor = UIColor.whiteColor()
          self.boardView.colorType = 2
          self.xiangpiSlideClick(self.xiangpiSlide)
    }
    
    
    @IBAction func albumButtonClick(sender: AnyObject) {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        {  return
        }
        let ipc = UIImagePickerController.init()
        ipc.delegate = self
        self.presentViewController(ipc, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.setUpDrawingView(image)
    }
    
    @IBAction func cameralButtonClick(sender: AnyObject) {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            return
        }
        let ipc = UIImagePickerController.init()
        ipc.sourceType = UIImagePickerControllerSourceType.Camera
        ipc.delegate = self
        self.presentViewController(ipc, animated: true, completion: nil)
    }
    
    @IBAction func decidePosition(sender: AnyObject) {
         
         self.boardView.decidePosition()
    }
    
    
    @IBAction func clipGetImageStartClick(sender: UIButton) {
        
         if self.boardView.clipType == true
         {
              self.boardView.clipType = false
              sender.setTitle("取图", forState: UIControlState.Normal)
         }
         else
         {
            self.boardView.clipType = true
            sender.setTitle("取消", forState: UIControlState.Normal)
         }
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

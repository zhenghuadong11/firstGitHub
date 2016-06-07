//
//  MYImageEvvaluationViewController.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/5/3.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit
protocol  MYImageEvvaluationViewControllerDelegate{
    
    func imageEvvaluationViewController(viewController:MYImageEvvaluationViewController,image:UIImage) -> Void
}

class MYImageEvvaluationViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MYDrawingBoardViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var delegate:MYImageEvvaluationViewControllerDelegate?
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func albumClick(sender: AnyObject) {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        {  return
        }
        let ipc = UIImagePickerController.init()
        ipc.delegate = self
        self.presentViewController(ipc, animated: true, completion: nil)
    }
    @IBAction func cameraClick(sender: AnyObject) {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            return
        }
        let ipc = UIImagePickerController.init()
        ipc.sourceType = UIImagePickerControllerSourceType.Camera
        ipc.delegate = self
        self.presentViewController(ipc, animated: true, completion: nil)
    }
    
    @IBAction func selfDecideClick(sender: AnyObject) {
        let drawViewController = MYDrawingBoardViewController()
        drawViewController.delegate = self
        self.presentViewController(drawViewController, animated: true, completion: nil)
    }

    @IBAction func makeSureClick(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
         self.delegate?.imageEvvaluationViewController(self, image: self.imageView.image!)
    }

    @IBAction func cancleClick(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = image
    }
    func drawingBoardViewController(drawViewController: MYDrawingBoardViewController, image: UIImage) {
        self.imageView.image = image
        
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

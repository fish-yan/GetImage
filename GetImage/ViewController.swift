//
//  ViewController.swift
//  GetImage
//
//  Created by 薛焱 on 16/1/27.
//  Copyright © 2016年 薛焱. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoView: UIImageView!
    var selectView: UIView!
    var beginPoint: CGPoint!
    var endPoint: CGPoint!
    var isShow: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoView.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationController?.navigationBar.hidden = false
    }
    

    @IBAction func printScreen(sender: UIBarButtonItem) {
        self.push(self.getFullScreen())
    }

    @IBAction func showNavi(sender: UITapGestureRecognizer) {
        if self.isShow {
            self.navigationController?.navigationBar.hidden = true
        }else{
            self.navigationController?.navigationBar.hidden = false
        }
        self.isShow = !self.isShow
    }
    @IBAction func openPhotoAlbum(sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.photoView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.beginPoint = touches.first?.locationInView(self.view)
        self.selectView = UIView(frame: CGRect(x: beginPoint.x, y: beginPoint.y, width: 10, height: 10))
        selectView.layer.borderColor = UIColor.whiteColor().CGColor
        selectView.layer.borderWidth = 1
  
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = (touches.first?.locationInView(self.view))! as CGPoint
        let rect = self.getRect(self.beginPoint, endPoint: point)
        self.selectView.frame = rect
        if selectView.frame.size.height > 20 && selectView.frame.size.width > 20 {
            self.view.addSubview(selectView)
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.endPoint = touches.first?.locationInView(self.view)
        var rect = self.getRect(self.beginPoint, endPoint: self.endPoint)
        let size = CGSize(width: rect.size.width - 2, height: rect.size.height - 2)
        rect.size = size
        if rect.size.height > 20 && rect.size.width > 20 {
            self.push(self.getImage(rect))
        }
       selectView.removeFromSuperview()
    }
    
    func getRect(beginPoint: CGPoint, endPoint: CGPoint) -> CGRect {
        var x:CGFloat
        var y:CGFloat
        var w:CGFloat
        var h:CGFloat
        if beginPoint.x < endPoint.x {
            x = beginPoint.x
            w = endPoint.x - beginPoint.x
        }else{
            x = endPoint.x
            w = beginPoint.x - endPoint.x
        }
        if beginPoint.y < endPoint.y {
            y = beginPoint.y
            h = endPoint.y - beginPoint.y
        }else{
            y = endPoint.y
            h = beginPoint.y - endPoint.y
        }
        
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    func getFullScreen() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(UIScreen.mainScreen().bounds.size, false, 1.0)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    func getImage(rect: CGRect) -> UIImage {
        
        let imageRef = self.getFullScreen().CGImage
        let smallImageRef = CGImageCreateWithImageInRect(imageRef, rect)
        let context = UIGraphicsGetCurrentContext()
        CGContextDrawImage(context, rect, smallImageRef)
        let smallImage = UIImage(CGImage: smallImageRef!)
        UIGraphicsEndImageContext()
        return smallImage

    }
    
    func push(image: UIImage){
        let secVC = self.storyboard?.instantiateViewControllerWithIdentifier("SecViewController") as! SecViewController
        secVC.image11 = image
        self.navigationController?.pushViewController(secVC, animated: true)
    }

}


//
//  SecViewController.swift
//  GetImage
//
//  Created by 薛焱 on 16/1/27.
//  Copyright © 2016年 薛焱. All rights reserved.
//

import UIKit

class SecViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var image11: UIImage!
    var isShow: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.image = self.image11
        self.image.contentMode = UIViewContentMode.Center
        self.navigationController?.navigationBar.hidden = false
        // Do any additional setup after loading the view.
    }

    @IBAction func saveImage(sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(self.image11, self, Selector("image:didFinishSavingWithError:contextInfo:"), nil)
    }
    func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject){
        let alert = UIAlertController(title: "提示", message: "保存成功", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(alert, animated: true, completion: nil)
        self.performSelector(Selector("dismiss"), withObject: alert, afterDelay: 1)
        if (didFinishSavingWithError != nil) {
            
        }else{
            
        }
    }
    func dismiss(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func showNavi(sender: UITapGestureRecognizer) {
        if self.isShow {
            self.navigationController?.navigationBar.hidden = true
        }else{
            self.navigationController?.navigationBar.hidden = false
        }
        self.isShow = !self.isShow
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

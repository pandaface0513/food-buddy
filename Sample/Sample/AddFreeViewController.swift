//
//  AddFeedViewController.swift
//  Project Foodie
//
//  Created by Henry on 2015-02-28.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class AddFeedViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate {
    
    let alertView = UIAlertView(title: "Alert!", message: "Text or Photo is missing...", delegate: nil, cancelButtonTitle: "OK")
    let failView = UIAlertView(title: "Alert!", message: "Upload failed...", delegate: nil, cancelButtonTitle: ":(")
    let db:PostDataBase = PostDataBase()
    let usr:User = User()
    
    //var img:UIImage!
    var imgData:NSData!
    
    @IBAction func cancelBtn(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBOutlet weak var myImage: UIImageView!
    let picker = UIImagePickerController()
    
    @IBOutlet weak var textField: UITextView!
    
    @IBOutlet weak var TextViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        textField.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        uploadFromGallery()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size.height {
                TextViewConstraint.constant += keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size.height {
                TextViewConstraint.constant -= keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    @IBAction func cameraBtn(sender: AnyObject) {
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.cameraCaptureMode = .Photo
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func galleryBtn(sender: AnyObject) {
        uploadFromGallery()
    }
    
    @IBAction func doneBtn(sender: AnyObject) {
        //check content and image
        if (textField.text.isEmpty || myImage?.image? == nil) {
            alertView.show();
        }else{
            //below crop image to certain size (640 x 640)
            //var croppedImg:UIImage = cropImageTo(myImage.image!, scaledToSize: CGSizeMake(640, 640))
            //println(myImage.image!.size);
            //println(croppedImg.size);
            //below convert image to jpeg with 60% quality
//            var imgData:NSData = UIImageJPEGRepresentation(img, 0.6)
            //var beforeData:NSData = UIImageJPEGRepresentation(myImage.image!, 1.0)
            //println(beforeData.length)
            //println(imgData.length)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "upLoadPostDone:", name: "upload Done", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "upLoadPostFail:", name: "upload Failed", object: nil)
            
            var postData:Dictionary<String, AnyObject!> = ["userid": usr.getObjectId(), "user": usr.getUsername(), "description": textField.text, "imagefile": imgData, "location": "Victor's House"]
            db.upload(postData)
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    //function for upload done
    func upLoadPostDone(notifcation: NSNotification){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "upload Done", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "upload Failed", object: nil)
        //self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    //function for upload fail
    func upLoadPostFail(notifcation: NSNotification){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "upload Done", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "upload Failed", object: nil)
        failView.show()
    }
    
    
    //function to crop iamge to a certain size
    func cropImageTo(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        var newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func uploadFromGallery(){
        picker.sourceType = .PhotoLibrary //3
        presentViewController(picker, animated: true, completion: nil)//4
    }
    
    //MARK: Delegates
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerEditedImage] as UIImage //2
        myImage.contentMode = .ScaleAspectFit//3
        chosenImage = cropImageTo(chosenImage, scaledToSize: CGSizeMake(640, 640))
        imgData = UIImageJPEGRepresentation(chosenImage, 0.6)
        myImage.image = chosenImage //4
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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

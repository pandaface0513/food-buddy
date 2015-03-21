//
//  AddFeedViewController.swift
//  Project Foodie
//
//  Created by Henry on 2015-02-28.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class AddFeedViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    let alertView = UIAlertView(title: "Alert!", message: "Text or Photo is missing...", delegate: nil, cancelButtonTitle: "OK")
    
    
    @IBAction func cancelBtn(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBOutlet weak var myImage: UIImageView!
    let picker = UIImagePickerController()
    
    @IBOutlet weak var myText: UITextField!
    
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        myText.delegate = self
        
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
                textViewBottomConstraint.constant += keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size.height {
                textViewBottomConstraint.constant -= keyboardHeight
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
        if (myText.text.isEmpty || myImage?.image? == nil) {
            alertView.show();
        }else{
            //below convert image to jpeg with 1.0 quality
            var imgData:NSData = UIImageJPEGRepresentation(myImage.image, 0.8)
            
        }
        //self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func uploadFromGallery(){
        picker.sourceType = .PhotoLibrary //3
        presentViewController(picker, animated: true, completion: nil)//4
    }
    
    //MARK: Delegates
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as UIImage //2
        //        myImage.contentMode = .ScaleAspectFit myImage. //3
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

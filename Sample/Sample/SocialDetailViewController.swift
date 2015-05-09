//
//  SocialDetailViewController.swift
//  Project Foodie
//
//  Created by Victor on 2015-02-11.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation
import UIKit

class SocialDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate  {
    @IBOutlet weak var tableView: UITableView!
    
    var imageURL : String?
    var postID : String?
    var userName: String?
    
    var commentArr : [Comment] = [Comment]()
    
//    var db:PostDataBase = PostDataBase()
    var commentDB:CommentDataBase = CommentDataBase()
    
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var toolbarConstraint: NSLayoutConstraint!
    
    @IBAction func backBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func submitBtn(sender: AnyObject) {
        if(!commentField.text.isEmpty){
            //uploadComments
            println("trying to upload - " + commentField.text)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "uploadDone:", name: "uploadComment Done", object: nil)
            commentDB.uploadComment(postID!, userId: PFUser.currentUser().objectId, comment: ["comment": commentField.text as String])
            self.view.endEditing(true)
            commentField.text = nil
        }
    }
    
    func uploadDone(notification:NSNotification){
        println("upload completed")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "uploadComment Done", object: nil)
    }
    
    func downloadComments(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadComments:", name: "downloadComment Done", object: nil)
        commentDB.downloadComment(postID!, userId: PFUser.currentUser().objectId)
    }
    
    func loadComments(notification:NSNotification){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "downloadComment Done", object: nil)
        println(notification.object as! String)
        //        for(var i = 0; i < 5; i++){
        //            var name = "henry " + String(i)
        //            var comment = "stuff " + String(i)
        //            commentArr.append(Comment(name: name, comment: comment))
        //        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentField.delegate = self
        
        downloadComments()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentArr.count + 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0){
            return 360
        }
        else {
            return 50
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: SocialDetailTableViewCell
        
        if (indexPath.row == 0) {
            cell = tableView.dequeueReusableCellWithIdentifier("imageCell") as! SocialDetailTableViewCell
            cell.loadItem(imageURL!)
            cell.sizeToFit()
            //        cell.textLabel?.text = personArr[indexPath.row].nameF
            
            //        var imageURL = NSURL(string: personArr[indexPath.row].img)
            //        var imageData = NSData(contentsOfURL: imageURL!)
            //        cell.imageView!.image = UIImage(data: imageData!)
            
            //return cell
            //println(imageURL!)
        }
        else {
            cell = tableView.dequeueReusableCellWithIdentifier("commentCell")as! SocialDetailTableViewCell
            cell.loadItem(commentArr[indexPath.row - 1].name, comment: commentArr[indexPath.row - 1].comment)
            cell.sizeToFit()
            //        cell.textLabel?.text = personArr[indexPath.row].nameF
            
            //        var imageURL = NSURL(string: personArr[indexPath.row].img)
            //        var imageData = NSData(contentsOfURL: imageURL!)
            //        cell.imageView!.image = UIImage(data: imageData!)
            
            //return cell
            //println(commentArr[indexPath.row - 1])
        }
        return cell
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size.height {
                toolbarConstraint.constant += keyboardHeight*0.78
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size.height {
                toolbarConstraint.constant -= keyboardHeight*0.78
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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

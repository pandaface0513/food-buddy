//
//  SocialDetailViewController.swift
//  Project Foodie
//
//  Created by Victor on 2015-02-11.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation
import UIKit

class SocialDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var imageURL : String?
    var name : String?
    var age : Int?
    
    var personArr : [Person] = [Person]()
    var commentArr : [Comment] = [Comment]()
//    let identifier : String = "commentCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for(var i = 0; i < 20; i++){
            var name = "henry " + String(i)
            var comment = "stuff " + String(i)
            commentArr.append(Comment(name: name, comment: comment))
        }
        // Do any additional setup after loading the view.
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: SocialDetailTableViewCell
        
        if (indexPath.row == 0) {
            cell = tableView.dequeueReusableCellWithIdentifier("imageCell") as SocialDetailTableViewCell
            cell.loadItem(imageURL!)
            //        cell.textLabel?.text = personArr[indexPath.row].nameF
            
            //        var imageURL = NSURL(string: personArr[indexPath.row].img)
            //        var imageData = NSData(contentsOfURL: imageURL!)
            //        cell.imageView!.image = UIImage(data: imageData!)
            
            //return cell
            println(imageURL!)
        }
        else {
            cell = tableView.dequeueReusableCellWithIdentifier("commentCell") as SocialDetailTableViewCell
            cell.loadItem(commentArr[indexPath.row - 1].name, comment: commentArr[indexPath.row - 1].comment)
            //        cell.textLabel?.text = personArr[indexPath.row].nameF
            
            //        var imageURL = NSURL(string: personArr[indexPath.row].img)
            //        var imageData = NSData(contentsOfURL: imageURL!)
            //        cell.imageView!.image = UIImage(data: imageData!)
            
            //return cell
            println(commentArr[indexPath.row - 1])
        }
        println("WTF")
        return cell
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

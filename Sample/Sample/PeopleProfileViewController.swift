//
//  PeopleProfileViewController.swift
//  Project Foodie
//
//  Created by Stardustxx on 2015-04-30.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class PeopleProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var PeopleProfileTable: UITableView!
    
    var postArr:[Dictionary<String, AnyObject>] = [Dictionary]()
    var user = User()
    var postDatabase = PostDataBase()
    var username : String = ""
    
    var reachedUsername:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reachedUsername = self.username
        println("people profile view " + self.username)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotPost:", name: "download Done", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotNoPost:", name: "download Failed", object: nil)
        
        postDatabase.downloadEqualTo(["user" : reachedUsername])

        // Do any additional setup after loading the view.
    }
    
    func gotPost(notification: NSNotification){
        var arr : Array<Dictionary<String, AnyObject>> = notification.object as! Array<Dictionary<String, AnyObject>>
        for feed in arr {
            postArr.append(feed)
        }
        println("people profile got post")
        
        self.PeopleProfileTable.reloadData()
    }
    
    func gotNoPost(notification: NSNotification){
        println("got no post")
        println(notification.object as! String)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postArr.count + 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0){
            return 100
        }
        else {
            return 360
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: PeopleProfileTableViewCell
        
        if (indexPath.row == 0){
            var identifier = "PeopleProfileInfo"
            cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! PeopleProfileTableViewCell
            cell.loadProfileInfo("http://www.punchbrand.com/blog/wp-content/uploads/2012/04/PIN-MEGUSTA.jpg", username: self.reachedUsername)
            cell.frame.size.height = 123
            cell.sizeToFit()
        }
        else {
            var identifier = "PeoplePerviousPost"
            cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! PeopleProfileTableViewCell
            let post:Dictionary<String,AnyObject> = postArr[indexPath.row - 1] as Dictionary
            
            cell.loadItem(post["imagefile"] as! String, description: post["description"] as! String)
            cell.sizeToFit()
        }
        
        return cell
    }
    
    @IBAction func cencel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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

//
//  ProfileTableViewController.swift
//  Project Foodie
//
//  Created by Stardustxx on 2015-04-11.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    var postArr:[Dictionary<String, AnyObject>] = [Dictionary]()
    var user = User()
    var postDatabase = PostDataBase()
    var database = DataBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadMyPost:", name: "findMyPost", object: nil)
        
        postDatabase.downloadEqualTo(["objectId": user.getObjectId()])
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadMyPost(notifaction:NSNotification){
        var arr : Array<Dictionary<String, AnyObject>> = notification.object as Array
        postArr = [Dictionary]()
        for dick in arr {
            println(dick)
            println(dick["user"])
            postArr.append(dick)
        }
        //reload that shit
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.postArr.count + 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ProfileTableViewCell
        
        if (indexPath.row == 0){
            cell = tableView.dequeueReusableCellWithIdentifier("profileInfo") as! ProfileTableViewCell
            cell.loadProfileInfo("picurl", username: user.getUsername() as String)
        }
        else {
            cell = tableView.dequeueReusableCellWithIdentifier("previousPost") as! ProfileTableViewCell
            let post:Dictionary<String,AnyObject> = postArr[indexPath.row - 1] as Dictionary
            
            cell.loadItem(post["imagefile"] as! String, description: post["description"] as! String)
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

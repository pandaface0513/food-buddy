//
//  FollowingViewController.swift
//  Project Foodie
//
//  Created by Stardustxx on 2015-04-29.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class FollowingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var followingTable: UITableView!
    
    let identifier = "followCell"
    var friendArr : Array<String> = []
    var user = User()
    var userdb = UserDataBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotFriends:", name: "getFriends Done", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotNoFriends:", name: "getFriends Failed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotFriendError:", name: "getFriends Failed", object: nil)
        
        userdb.getFriends(user.getObjectId())
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gotFriends(notification: NSNotification){
        println("got friends")
        var friends: Array<Dictionary<String, AnyObject>> = notification.object as! Array<Dictionary<String, AnyObject>>
        for friend in friends {
            friendArr.append(friend["username"] as! String)
        }
        println("done sorting friends")
        println(friendArr)
        self.followingTable.reloadData()
    }
    
    func gotNoFriends(notification: NSNotification){
        println("u no frieds")
    }
    
    func gotFriendError(notification:NSNotification){
        println("getFriends Failed")
        println(notification.object as! String)
    }
    
    //Table related stuffs
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : FollowersTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.identifier) as! FollowersTableViewCell
        
        var friendItem = friendArr[indexPath.row]
        println("Showing Friend: " + friendItem)
        
        cell.loadItem("http://www.punchbrand.com/blog/wp-content/uploads/2012/04/PIN-MEGUSTA.jpg", name: friendItem)
        
        return cell
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "moreAboutPerson"){
            var peopleView : PeopleProfileViewController = segue.destinationViewController as! PeopleProfileViewController
            var indexpath = followingTable.indexPathForSelectedRow()
            peopleView.username = friendArr[indexpath!.row]
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

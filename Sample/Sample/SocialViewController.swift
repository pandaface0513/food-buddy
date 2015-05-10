//
//  SocialViewController.swift
//  Project Foodie
//
//  Created by Victor on 2015-02-11.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class SocialViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var socialTable: UITableView!
    
    let identifier = "tableCell"
    var postArr:[Dictionary<String, AnyObject>] = [Dictionary]()
    var user = User()
    var postDatabase = PostDataBase()
    var restdb = RestaurantDataBase()
    var feedArr : Array<Dictionary<String, AnyObject>> = []
    
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "reload:", forControlEvents: UIControlEvents.ValueChanged)
        socialTable.addSubview(refreshControl)
        
        
        var screenSize: CGRect = UIScreen.mainScreen().bounds
        println(PFUser.currentUser().username)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "upLoadPostDone:", name: "upload Done", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "upLoadPostFail:", name: "upload Done", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "FeedLoad:", name: "findFriendFeed done", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "FeedLoadFailed:", name: "findFriendFeed failed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "AddFeed:", name: "addFriendFeed done", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "findRanRest:", name: "findRandomRestaurantCloud Done", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "findNoRanRest:", name: "findRandomRestaurantCloud Failed", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "grabRanRest:", name: "done grabbing", object: nil)
        
        
//        postDatabase.findFriendFeed(user.getObjectId(), loadMore: false)
        
        restdb.findRandomRestaurantCloud()
        
        // Do any additional setup after loading the view.
    }
    
    func grabRanRest(notification:NSNotification){
        var gpoint = PFGeoPoint(latitude: 49.249, longitude: -123.0196)
        restdb.findRandomRestaurantCloudHelper(gpoint)
    }
    
    func findRanRest(notification:NSNotification){
        var restResult = notification.object as! Dictionary<String, AnyObject>
        println("find random rest")
        println(restResult)
        postArr.append(restResult)
        println("postArr + \(postArr.count)")
        socialTable.reloadData()
    }
    
    func findNoRanRest(notification:NSNotification){
        println("find no ran rest")
        println(notification.object as! String)
    }
    
    func AddFeed(notification: NSNotification){
        println("add feed")
        var feedArr : Array<Dictionary<String, AnyObject>> = notification.object as! Array
        for feed in feedArr {
            postArr.append(feed)
        }
        println(String(postArr.count))
        socialTable.reloadData()
    }
    
    func FeedLoad(notification: NSNotification){
        println("got it")
        feedArr = notification.object as! Array
        postArr = [Dictionary]()
        for feed in feedArr {
            println(feed)
            postArr.append(feed)
        }
        //reload that shit
        socialTable.reloadData()
        NSNotificationCenter.defaultCenter().postNotificationName("done grabbing", object: nil)
    }
    
    func FeedLoadFailed(notification: NSNotification){
        println("shit")
    }
    
    //function for upload done
    func upLoadPostDone(notifcation: NSNotification){
        postDatabase.findAllPostCloud()
        println("got notification")
    }
    
    //function for upload fail
    func upLoadPostFail(notifcation: NSNotification){
        //failView.show()
    }
    
    //function to reload
    func reload(sender:AnyObject){
        //postDatabase.findAllPost()
        postDatabase.findFriendFeed(user.getObjectId(), loadMore: false)
        println("reloading")
        self.refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // Creating fake data for testing purpose
//    func setupPeople() {
//        for (var x = 0; x < 15; x++){
//            var nameF = "henry" + String(x)
//            var nameL = "Lu"
//            var age = Int(arc4random_uniform(40))
//            var desc = "Lorem ipsum dolor sit amet"
//            
//            var p = Person(nameF: nameF, nameL : nameL, age: age, image: "http://lorempixel.com/400/400/food/"+String(x), desc: desc)
//            personArr.append(p)lo9
//        }
//    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: SocialTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.identifier) as! SocialTableViewCell
        
        let post:Dictionary<String,AnyObject> = postArr[indexPath.row] as Dictionary
        
        if (indexPath.row == 10){
            cell.loadItem(post["name"] as! String, feedphoto: post["imagePFFile"] as! String, description: post["description"] as! String)
        }
        else {
            cell.loadItem(post["user"] as! String, feedphoto: post["imagefile"] as! String, description: post["description"] as! String)
            cell.setPostID(post["objectId"] as! String)
            cell.setLikeNumber(post["likeCount"] as! Int)
        }
        println(String(indexPath.row))

        if (indexPath.row == postArr.count - 1){
            println("bottom")
            postDatabase.needToLoad = true
            postDatabase.findFriendFeed(user.getObjectId(), loadMore: true)
        }
        
//        cell.textLabel?.text = personArr[indexPath.row].nameF
        
//        var imageURL = NSURL(string: personArr[indexPath.row].img)
//        var imageData = NSData(contentsOfURL: imageURL!)
//        cell.imageView!.image = UIImage(data: imageData!)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "socialDetail") {
            let index = socialTable?.indexPathForSelectedRow()  //find out the index of the cell selected
            let cell = socialTable?.cellForRowAtIndexPath(index!) as! SocialTableViewCell //fetch the cell using the index
            
            var socialDetail : SocialDetailViewController = segue.destinationViewController as! SocialDetailViewController
            
            socialDetail.userName = PFUser.currentUser().username
            socialDetail.postID = cell.getPostID()
            socialDetail.imageURL = cell.getImgURL()
            
        }
//        else if (segue.identifier == "loginScreen") {
//            PFUser.logOut()
//        }
    }

    @IBAction func logoff(sender: AnyObject) {
        PFUser.logOut()
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

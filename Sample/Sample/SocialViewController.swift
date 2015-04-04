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
    
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "reload:", forControlEvents: UIControlEvents.ValueChanged)
        socialTable.addSubview(refreshControl)
        
        
        
        var screenSize: CGRect = UIScreen.mainScreen().bounds
        println(PFUser.currentUser().username)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "testLoad:", name: "findAllPost Done", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "upLoadPostDone:", name: "upload Done", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "upLoadPostFail:", name: "upload Done", object: nil)
        
        postDatabase.findAllPost()
        
        //postDatabase.downloadContainedIn([:])
        

        
        
        // Do any additional setup after loading the view.
    }
    
    //function for upload done
    func upLoadPostDone(notifcation: NSNotification){
        postDatabase.findAllPost()
        println("got notification")
    }
    
    //function for upload fail
    func upLoadPostFail(notifcation: NSNotification){
        //failView.show()
    }
    
    //function to reload
    func reload(sender:AnyObject){
        postDatabase.findAllPost()
        println("reloading")
        self.refreshControl.endRefreshing()
    }
    
    
    func testLoad(notification : NSNotification){
        var arr : Array<Dictionary<String, AnyObject>> = notification.object as Array
        postArr = [Dictionary]()
        for dick in arr {
            println(dick)
            println(dick["user"])
            postArr.append(dick)
        }
        //reload that shit
        socialTable.reloadData()
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
//            personArr.append(p)
//        }
//    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: SocialTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.identifier) as SocialTableViewCell
        
        let post:Dictionary<String,AnyObject> = postArr[indexPath.row] as Dictionary
        
        cell.loadItem(post["user"] as String, feedphoto: post["imagefile"] as String, description: post["description"] as String)
//        cell.textLabel?.text = personArr[indexPath.row].nameF
        
//        var imageURL = NSURL(string: personArr[indexPath.row].img)
//        var imageData = NSData(contentsOfURL: imageURL!)
//        cell.imageView!.image = UIImage(data: imageData!)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "socialDetail" {
            let index = socialTable?.indexPathForSelectedRow()
            
            var socialDetail : SocialDetailViewController = segue.destinationViewController as SocialDetailViewController
            
            socialDetail.name = "fk"
            socialDetail.age = 1
            socialDetail.imageURL = "www.google.com"
            
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

//
//  TableBumpViewController.swift
//  Project Foodie
//
//  Created by Stardustxx on 2015-05-01.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class TableBumpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var friendsView: UITableView!
    
    var user = User()
    var userdb = UserDataBase()
    
    var friendArr : Array<String> = []
    var testarr : Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotFriends:", name: "getFriends Done", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotNoFriends:", name: "getFriends Failed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotFriendError:", name: "getFriends Failed", object: nil)
        
        userdb.getFriends(user.getObjectId())
        
        // Do any additional setup after loading the view.
    }
    
    func gotFriends(notification: NSNotification){
        println("Table got friends")
        var friends : Array<Dictionary<String, AnyObject>> = notification.object as! Array<Dictionary<String, AnyObject>>
        for friend in friends {
            friendArr.append(friend["username"] as! String)
        }
        self.friendsView.reloadData()
    }
    
    func gotNoFriends(notification: NSNotification){
        println("Table got no friends")
    }
    
    func gotFriendError(notification: NSNotification){
        println("Table got friend error")
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
        return self.friendArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "TableFriends"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! TableFriendsTableViewCell
        cell.loadItem("http://www.punchbrand.com/blog/wp-content/uploads/2012/04/PIN-MEGUSTA.jpg",friend: friendArr[indexPath.row])
        
        return cell
    }
    
//    @IBAction func sup(sender: AnyObject) { //the NEXT button
//        println("Table result")
//        
//        testarr = []
//        
//        for cell in self.friendsView.visibleCells() as! [TableFriendsTableViewCell]{
//            let checked = cell.getSwitchState()
//            if(checked){
//                testarr.append(cell.getUserName())
//            }
//        }
//        println(testarr)
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "TableResult"){
            var tableResultView : TableResultViewController = segue.destinationViewController as! TableResultViewController
            var selectedFriendsArr : Array<String> = []
    
            for cell in self.friendsView.visibleCells() as! [TableFriendsTableViewCell]{
                let checked = cell.getSwitchState()
                if(checked){
                    selectedFriendsArr.append(cell.getUserName())
                }
            }
            
            println("selectedFriends")
            println(selectedFriendsArr)
            
            //pass to tableResultView
            tableResultView.selectedFriends = selectedFriendsArr
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

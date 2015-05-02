//
//  TableResultViewController.swift
//  Project Foodie
//
//  Created by Stardustxx on 2015-05-01.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class TableResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableResult: UITableView!
    
    var selectedFriends : Array<String> = []
    //var userids : Array<String> = []
    var restInfo : Array<Dictionary<String, AnyObject>> = []
    
    var restdb = RestaurantDataBase()

    override func viewDidLoad() {
        super.viewDidLoad()
        println("data received")
        println(selectedFriends)
        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotFood:", name: "findBestSuitedRestaurantsCloud Done", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotNoFood:", name: "findBestSuitedRestaurantsCloud Failed", object: nil)
        
        var geoPoint = PFGeoPoint(latitude: 49.249, longitude: -123.0196)
        restdb.findBestSuitedRestaurantsCloudHelper(geoPoint,userIds:selectedFriends, rangeKiloRadius: 40)
        
        //restdb.findBestSuitedRestaurantsCloud(selectedFriends, rangeKiloRadius: 40)
        
    }
    
    func gotFood(notification:NSNotification){
        println("Me got food")
        var results : Array<Dictionary<String, AnyObject>> = notification.object as! Array
        for result in results {
            self.restInfo.append(result)
        }
        
        self.TableResult.reloadData()
    }
    
    func gotNoFood(notification:NSNotification){
        println("Me no food")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restInfo.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var identifier = "TableResultCellInfo"
        var cell : TableResultTableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier) as! TableResultTableViewCell
        
        cell.loadItem(restInfo[indexPath.row]["name"] as! String, score: restInfo[indexPath.row]["score"] as! Double, dist: restInfo[indexPath.row]["distance"] as! Double)
        
        return cell
    }

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "restProfile"){
            var restView : NearMeDetailViewController = segue.destinationViewController as! NearMeDetailViewController
            var indexpath = TableResult.indexPathForSelectedRow()
            //restdb.findRestaurantWithID(restInfo[indexpath!.row]["objectId"] as! String)
            restView.loadItem(restInfo[indexpath!.row]["imageUrl"] as! String, restName: restInfo[indexpath!.row]["name"] as! String, dist: restInfo[indexpath!.row]["distance"] as! Double)
            println(restInfo[indexpath!.row]["imageUrl"])
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

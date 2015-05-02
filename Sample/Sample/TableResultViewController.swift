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

    override func viewDidLoad() {
        super.viewDidLoad()
        println("data received")
        println(selectedFriends)
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
        return self.selectedFriends.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var identifier = "TableResultCellInfo"
        var cell : TableResultTableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier) as! TableResultTableViewCell
        
        
        
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

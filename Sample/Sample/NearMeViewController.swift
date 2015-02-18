//
//  SecondViewController.swift
//  Sample
//
//  Created by Victor on 2015-02-11.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class NearMeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var nearTable: UITableView!
    
    let identifier = "NearTable"
    
    var arr : [NearMe] = [NearMe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNearMe()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNearMe() {
        for (var x = 0; x < 15; x++){
            var nameF = "henry" + String(x)
            var nameL = "Lu"
            var age = Int(arc4random_uniform(40))
            var p = NearMe(nameF: nameF, nameL : nameL, age: age, image: "http://www.cats.org.uk/uploads/images/pages/photo_latest14.jpg")
            arr.append(p)
        }

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(self.identifier) as UITableViewCell
        
        cell.textLabel?.text = arr[indexPath.row].nameF
        
        return cell
    }



}


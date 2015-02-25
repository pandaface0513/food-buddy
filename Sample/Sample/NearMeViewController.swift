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
        for (var x = 0; x < 10; x++){
            var name = "Bad Restaurant" + String(x)
            var type = "Taste Bad"
            var distance = Int(arc4random_uniform(40))
            var n = NearMe(name: name, type: type, distance: distance, image: "http://lorempixel.com/500/500/nightlife/"+String(x))
            arr.append(n)
        }

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:NearMeTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.identifier) as NearMeTableViewCell
        
        var place = arr[indexPath.row]
        
        cell.loadItem(place.name, placephoto: place.img, placedist: place.distance, placetype: place.type)
        
        return cell
    }



}


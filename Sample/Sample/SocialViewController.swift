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
    var personArr : [Person] = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupPeople()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func setupPeople() {
        personArr = [
            Person(nameF: "Jennifer", nameL : "Lee", age: 22, image: "http://www.cats.org.uk/uploads/images/pages/photo_latest14.jpg"),
            Person(nameF: "Zora", nameL: "Lee", age: 18, image: "http://www.cats.org.uk/uploads/images/pages/photo_latest14.jpg"),
            Person(nameF: "Pika", nameL: "Chu", age: 99, image: "http://www.cats.org.uk/uploads/images/pages/photo_latest14.jpg")
        ]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.personArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(self.identifier) as UITableViewCell
        
        cell.textLabel?.text = personArr[indexPath.row].nameF
        
        var imageURL = NSURL(string: personArr[indexPath.row].img)
        var imageData = NSData(contentsOfURL: imageURL!)
        cell.imageView!.image = UIImage(data: imageData!)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "socialDetail" {
            let index = socialTable?.indexPathForSelectedRow()
            
            var socialDetail : SocialDetailViewController = segue.destinationViewController as SocialDetailViewController
            
            socialDetail.name = personArr[index!.row].nameF + " " + personArr[index!.row].nameL
            socialDetail.age = personArr[index!.row].age
            socialDetail.imageURL = personArr[index!.row].img
            
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

//
//  NearMeDetailViewController.swift
//  Project Foodie
//
//  Created by Victor on 2015-02-15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class NearMeDetailViewController: UIViewController {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distLabel: UILabel!
    
    
    var imageURL : String?
    var name : String?
    var dist : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = ""
        self.distLabel.text = "0"
        // Do any additional setup after loading the view.
    }
    
    func loadItem(imageurl: String, restName: String, dist: Double){
        println(restName)
        //self.nameLabel.text = restName
        //self.distLabel.text = String(format:"%.1f", dist)
        self.imageURL = imageurl
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            var nURL = NSURL(string: self.imageURL!)
            var imageData = NSData(contentsOfURL: nURL!)
            dispatch_async(dispatch_get_main_queue()) {
                self.picture.image = UIImage(data: imageData!)
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

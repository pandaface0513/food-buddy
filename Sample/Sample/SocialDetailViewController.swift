//
//  SocialDetailViewController.swift
//  Project Foodie
//
//  Created by Victor on 2015-02-11.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import Foundation
import UIKit

class SocialDetailViewController: UIViewController {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var imageURL : String?
    var name : String?
    var age : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nURL = NSURL(string: imageURL!)
        var imageData = NSData(contentsOfURL: nURL!)
        
        picture.image = UIImage(data: imageData!)
        nameLabel.text = name!
        ageLabel.text = String(age!)
        
        // Do any additional setup after loading the view.
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

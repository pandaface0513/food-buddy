//
//  ProfileTableViewCell.swift
//  Project Foodie
//
//  Created by Stardustxx on 2015-04-11.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadProfileInfo(usernamePic: String, username: String){
        self.username.text = username
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            var imageURL = NSURL(string: usernamePic)
            var imageData = NSData(contentsOfURL: imageURL!)
            dispatch_async(dispatch_get_main_queue()){
                self.profileImage.image = UIImage(data: imageData!)
            }
        }
    }
    
    func loadItem(feedphoto: String, description: String){
        postText.text = description
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            var imageURL = NSURL(string: feedphoto)
            var imageData = NSData(contentsOfURL: imageURL!)
            dispatch_async(dispatch_get_main_queue()){
            self.postImage.image = UIImage(data: imageData!)
            }
        }
    }
    
    @IBAction func followingList(sender: AnyObject) {
        println("following")
    }
    

    @IBAction func viewMore(sender: AnyObject) {
        println("view more")
    }
    
}

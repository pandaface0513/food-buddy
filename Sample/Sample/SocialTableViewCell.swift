//
//  SocialTableViewCell.swift
//  Project Foodie
//
//  Created by Victor on 2015-02-21.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class SocialTableViewCell: UITableViewCell {

    @IBOutlet weak var FeedPhoto: UIImageView!
    @IBOutlet weak var FeedUsername: UILabel!
    @IBOutlet weak var FeedDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadItem(feedusername: String, feedphoto: String, description: String){
        FeedUsername.text = feedusername
        FeedDesc.text = description
        
        
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            var imageURL = NSURL(string: feedphoto)
            var imageData = NSData(contentsOfURL: imageURL!)
            dispatch_async(dispatch_get_main_queue()){
                self.FeedPhoto.image = UIImage(data: imageData!)
            }
        }
        
//        FeedDesc.numberOfLines = 0
//        FeedDesc.preferredMaxLayoutWidth = 450
//        FeedDesc.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        FeedDesc.sizeToFit()
    }

}

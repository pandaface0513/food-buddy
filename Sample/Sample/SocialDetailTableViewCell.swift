//
//  SocialDetailTableViewCell.swift
//  Project Foodie
//
//  Created by Stardustxx on 2015-03-11.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class SocialDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var FeedPhoto: UIImageView!
    @IBOutlet weak var commentName: UILabel!
    @IBOutlet weak var commentText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func loadItem(feedphoto: String){
//        FeedUsername.text = feedusername
//        FeedDesc.text = description
        
        
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
    
    func loadItem(feedusername: String, comment: String){
        commentName.text = feedusername
        commentText.text = comment
    }

}

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
    @IBOutlet weak var likeCounts: UILabel!
    @IBOutlet weak var commentCounts: UILabel!
    
    var likeCount = 0
    var commentCount = 0
    
    var postId:String = ""
    var userId = PFUser.currentUser().objectId
    
    var likeDatabase = LikeDataBase()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeCounts.text = String(likeCount)
        commentCounts.text = String(commentCount)
        // Initialization code
    }

    @IBAction func likeAction(sender: AnyObject) {
        //check if its liked or not
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotlike:", name: "didLike Done", object: nil)
        likeDatabase.didLike(postId, userId: userId)
    }
    
    func gotlike(notification:NSNotification){
        //toggle like to the database
        var islike:String = notification.object as! String
        if(islike == "true"){
            likeDatabase.likeToggle(postId, userId: userId, isExisted: true)
            likeCount--
        }else{
            likeDatabase.likeToggle(postId, userId: userId, isExisted: false)
            likeCount++
        }
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "didLike Done", object: nil)
        //println(islike)
        likeCounts.text = String(likeCount)
    }
    
    @IBAction func commentAction(sender: AnyObject) {
        commentCount += 1
        commentCounts.text = String(commentCount)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPostID(id:String){
        postId = id
    }
    
    func setLikeNumber(like:Int){
        likeCount = like
        likeCounts.text = String(likeCount)
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

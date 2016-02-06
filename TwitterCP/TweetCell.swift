//
//  TweetCell.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/6/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            usernameLabel.text = tweet.username
            tweetTextLabel.text = tweet.text
            userProfilePic.setImageWithURL(NSURL(string: tweet.profilePicUrl!)!)
            timestampLabel.text = tweet.createdAtString
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userProfilePic.layer.cornerRadius = 3
        userProfilePic.clipsToBounds = true
        
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width

    }

    override func layoutSubviews() {
        super.layoutSubviews()
    
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

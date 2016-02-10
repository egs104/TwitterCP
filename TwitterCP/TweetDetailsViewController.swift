//
//  TweetDetailsViewController.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/9/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import UIKit
import AFNetworking

class TweetDetailsViewController: UIViewController {
    
    var selectedTweet: Tweet?
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profilePicImageView.setImageWithURL(NSURL(string: (selectedTweet?.profilePicUrl)!)!)
        nameLabel.text = selectedTweet?.username
        handleLabel.text = "@\(selectedTweet!.handle!)"
        tweetContentLabel.text = selectedTweet?.text
        retweetsLabel.text = "\(selectedTweet!.retweetCount!)"
        favoritesLabel.text = "\(selectedTweet!.favoriteCount!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

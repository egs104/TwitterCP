//
//  ProfileViewController.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/11/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController {
    
    var owningUser: User?

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var coverPhotoImageView: UIImageView!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profilePicImageView.setImageWithURL(NSURL(string: (owningUser?.profileImageUrl)!)!)
        coverPhotoImageView.setImageWithURL(NSURL(string: owningUser!.coverPhotoUrl!)!)
        tweetCountLabel.text = "\(owningUser!.tweetCount!)"
        followersCountLabel.text = "\(owningUser!.followersCount!)"
        followingCountLabel.text = "\(owningUser!.followingCount!)"
        nameLabel.text = owningUser?.name!
        handleLabel.text = "@\(owningUser!.screenname!)"
        
        profilePicImageView.layer.cornerRadius = 3
        profilePicImageView.clipsToBounds = true
        
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

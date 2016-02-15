//
//  ComposeViewController.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/14/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import UIKit
import AFNetworking

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var tweetTextArea: UITextView!
    
    @IBOutlet weak var currentUserImageView: UIImageView!
    @IBOutlet weak var currentUserName: UILabel!
    @IBOutlet weak var currentUserHandle: UILabel!
    
    var loggedInUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextArea.becomeFirstResponder()
        
        currentUserImageView.setImageWithURL(NSURL(string: (loggedInUser?.profileImageUrl)!)!)
        currentUserName.text = loggedInUser?.name
        currentUserHandle.text = "@\(loggedInUser!.screenname!)"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendTweet(sender: AnyObject) {
        if tweetTextArea.text != nil {
            var formattedTweet = tweetTextArea.text.stringByReplacingOccurrencesOfString(" ", withString: "%20")
            
            TwitterClient.sharedInstance.postTweet(formattedTweet)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
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

//
//  TweetsViewController.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/6/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: { (tweets: [Tweet]?, error: NSError?) -> Void in
            self.tweets = tweets
            //print(tweets)
            self.tableView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets![indexPath.row]
//        cell.retweetButton.tag = indexPath.row
//        cell.retweetButton.addTarget
        
        return cell

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if let cell = sender as? TweetCell {
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
        
            let detailViewController = segue.destinationViewController as! TweetDetailsViewController
            detailViewController.selectedTweet = tweet
        }
        
        if let profilePic = sender as? UIButton {
            if let superview = profilePic.superview {
                if let cell = superview.superview as? TweetCell {
                    let indexPath = tableView.indexPathForCell(cell)
                    
                    let tweet = tweets![indexPath!.row]
                    
                    let profileViewController = segue.destinationViewController as! ProfileViewController
                    profileViewController.owningUser = tweet.user
                }
            }
        }
        
        if let composeButton = sender as? UIBarButtonItem {
            let composeViewController = segue.destinationViewController as! ComposeViewController
            composeViewController.loggedInUser = User.currentUser
        }

    }

}

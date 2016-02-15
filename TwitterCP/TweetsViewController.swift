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
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        fetchTweets()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func fetchTweets() {
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: { (tweets: [Tweet]?, error: NSError?) -> Void in
            self.tweets = tweets
            //print(tweets)
            self.tableView.reloadData()
        })
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
        
        return cell

    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    func onRefresh() {
        delay(2, closure: {
            self.refreshControl.endRefreshing()
        })
        
        fetchTweets()
        
        self.refreshControl?.endRefreshing()
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

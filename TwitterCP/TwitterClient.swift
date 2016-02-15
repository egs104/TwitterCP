//
//  TwitterClient.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/2/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "V0C7ymMzXTgOt3Ulw7S5ty8rZ"
let twitterConsumerSecret = "b7Lp88gOlBkdFyHjkMTeEoP8nqpNXeNSCzdx33F51SQ3hZWpTJ"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimeLineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Home timeline: \(response)")
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
    
        }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
                print("error getting timeline")
                completion(tweets: nil, error: error)
        }

    }
    
    func postTweet(tweetContent: String) {
        POST("https://api.twitter.com/1.1/statuses/update.json?status=\(tweetContent)", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Tweet posted")
        }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
                print("error posting tweet")
        }
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // Fetch request token and redirect to authoriztion page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token!")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    
    func openURL(url: NSURL) {
        
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("got the access token!")
            
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                //print(response)
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print(error)
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            }
            
            }) { (error: NSError!) -> Void in
                print("Failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        }

        
    }
    
}

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
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
}

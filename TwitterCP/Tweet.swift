//
//  Tweet.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/4/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var user: User?
    var username: String?
    var text: String?
    var profilePicUrl: String?
    var createdAtString: String?
    var createdAt: NSDate?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        username = (user?.name)! as String
        profilePicUrl = dictionary["user"]!["profile_image_url_https"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
        
    }
    
}

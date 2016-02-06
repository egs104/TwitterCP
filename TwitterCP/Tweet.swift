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
    var favoriteCount: Int?
    var retweetCount: Int?
    //var didRetweet: Int?
    //var didFavorite: Int?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        username = (user?.name)! as String
        profilePicUrl = dictionary["user"]!["profile_image_url_https"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        favoriteCount = dictionary["favorite_count"] as? Int
        retweetCount = dictionary["retweet_count"] as? Int
        //didRetweet = dictionary["favorited"] as? Int
        //didFavorite = dictionary["retweeted"] as? Int
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
        
    }
    
}

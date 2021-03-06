//
//  ViewController.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/2/16.
//  Copyright © 2016 Eric Suarez. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                // perform segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
                
            } else {
                // handle login error
            }
        }

    }

}


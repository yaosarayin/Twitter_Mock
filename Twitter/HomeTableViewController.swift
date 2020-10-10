//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Yao on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberOfTweets = int!
    
    func loadTweets(){
        let loadUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let loadParams = {"count";:10}
    
        TwitterAPICaller.client.getDictionariesRequest(url:loadUrl, parameters:loadParemeters, success: {(tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for t in tweets {
                self.tweetArray.append(t)
            }
        }, failure: { (Erorr) in
            print("cannot retrieve timeline")
        })

    }
    
    
    @IBAction func onLogOut(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetTableViewCell
        
        cell.userNameLabel.text =
        cell.tweetContent.text =
        cell.profileImageView
        return cell
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

 
}

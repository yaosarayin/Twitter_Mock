//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Yao on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()

        print(self.tweetArray)
    }
    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    func loadTweets () {
        let loadUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let loadParams = ["count":10]

        TwitterAPICaller.client?.getDictionariesRequest(url:loadUrl, parameters: loadParams, success: {(tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for t in tweets {
                self.tweetArray.append(t)
                
            }
            self.tableView.reloadData()
            //print(self.tweetArray)
        }, failure: { (Erorr) in
            print("cannot retrieve timeline")
        })
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell
        
        let user = self.tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        return cell
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

 
}

 


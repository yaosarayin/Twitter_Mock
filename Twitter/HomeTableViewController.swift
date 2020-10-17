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
    var numberOfTweets: Int!
    
    let RefreshControl = UIRefreshControl()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        RefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = RefreshControl
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 140
        
        print(self.tweetArray)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTweets()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }

    @objc func loadTweets () {
        
        numberOfTweets = 20
        let loadUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let loadParams = ["count" : numberOfTweets]

        TwitterAPICaller.client?.getDictionariesRequest(url:loadUrl, parameters: loadParams as [String : Any], success: {(tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for t in tweets {
                self.tweetArray.append(t)
                
            }
            self.tableView.reloadData()
            self.RefreshControl.endRefreshing()
            //print(self.tweetArray)
        }, failure: { (Erorr) in
            print("Cannot retrieve timeline")
        })
    }
    
    @objc func loadMoreTweets () {
        numberOfTweets = numberOfTweets + 20
        let loadUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let loadParams = ["count" : numberOfTweets]

        TwitterAPICaller.client?.getDictionariesRequest(url:loadUrl, parameters: loadParams as [String : Any], success: {(tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for t in tweets {
                self.tweetArray.append(t)
                
            }
            self.tableView.reloadData()
            self.RefreshControl.endRefreshing()
            //print(self.tweetArray)
        }, failure: { (Erorr) in
            print("Cannot retrieve timeline")
        })
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    func timeIntervalFormat(interval: TimeInterval) -> NSString {
        if (interval < 60) {
            let (s,_) = Int(interval).quotientAndRemainder( dividingBy: 1)
            return "\(s) s ago" as NSString
        } else if (interval < 3600) {
            let (m,_) = Int(interval).quotientAndRemainder( dividingBy: 60)
            return "\(m) m ago" as NSString
        }
        else if (interval < 86400 ) {
            let (h,_) = Int(interval).quotientAndRemainder(dividingBy: 3600)
            return "\(h) h ago" as NSString
        }
        else {
            let (d,_) = Int(interval).quotientAndRemainder( dividingBy: 86400)
            return "\(d)) days ago" as NSString
        }
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
        
        let now = NSDate()
        
        let postedAtStr = self.tweetArray[indexPath.row]["created_at"]

        let postedAt = dateFormatter.date(from:postedAtStr as! String)!
        
        let interval = now.timeIntervalSince(postedAt)

        cell.postedAt.text = self.timeIntervalFormat(interval: interval) as String
            
        cell.setLiked(self.tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.setRetweeted(self.tweetArray[indexPath.row]["retweeted"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        
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

 


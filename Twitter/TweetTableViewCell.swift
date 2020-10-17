//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Yao on 10/10/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var postedAt: UILabel!
    
    var liked = false
    var tweetId: Int = -1 //negative number for unset
    var retweeted = false
    
    func setLiked(_ isliked:Bool) {
        liked = isliked
        if (liked) {
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        retweeted = isRetweeted
        if (liked) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func likeTweet(_ sender: Any) {
        let tobeLiked = !liked
        if (tobeLiked) {
            TwitterAPICaller.client?.likeTweet(tweetId: tweetId, success: {self.setLiked(true)}, failure: {(error) in print("Like tweet did not succeed: \(error)")})
        } else {
            TwitterAPICaller.client?.unlikeTweet(tweetId: tweetId, success: {self.setLiked(false)}, failure: {(error) in print("Unlike tweet did not succeed: \(error)")})
        }
    }
    

    @IBAction func retweet(_ sender: Any) {
        let tobeLiked = !liked
        if (tobeLiked) {
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {self.setRetweeted(true)}, failure: {(error) in print("Retweet did not succeed: \(error)")})
        } else {
            TwitterAPICaller.client?.unretweet(tweetId: tweetId, success: {self.setRetweeted(false)}, failure: {(error) in print("Un-retweet tweet did not succeed: \(error)")})
        }
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  TweetCell.swift
//  Twitter
//
//  Created by 이승헌 on 28/01/2019.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var tweet_content_label: UILabel!
    
    @IBOutlet weak var retweet_button: UIButton!
    @IBOutlet weak var favorite_button: UIButton!
    
    @IBAction func retweet_button_clicked(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.set_retweeted(true)
        }, failure: { (error) in
            print("Retweeted not succeed: \(error)")
        })
    }
    @IBAction func favorite_button_clicked(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.set_favorited(true)
            }, failure: { (error) in
                print("Favorited not succeed: \(error)")
            })
            
        } else {
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, success: {
                self.set_favorited(false)
            }, failure: { (error) in
                print("Unfavorited not succeed: \(error)")
            })
        }
    }
    
    var tweetId:Int = -1
    var favorited = false
    var retweeted = false
    
    func set_favorited(_ isFavorited: Bool){
        favorited = isFavorited
        if (favorited) {
            favorite_button.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favorite_button.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func set_retweeted(_ isRetweeted: Bool){
        retweeted = isRetweeted
        if(retweeted) {
            retweet_button.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweet_button.isEnabled = false
        } else {
            retweet_button.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweet_button.isEnabled = true
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

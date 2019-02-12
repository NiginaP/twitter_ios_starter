//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Admin on 2/3/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    var favorited:Bool = false
    var tweetID:Int = -1
    var retweeted:Bool = false
    
    func setFavorite(_ isFavorited: Bool){
        favorited = isFavorited
        if (favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweet(_ isRetweeted: Bool){
        retweeted = isRetweeted
        if (retweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
        
    }
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweetTweet(tweetID: tweetID, success: {
            self.setRetweet(true)
        }, failure: { (error) in
            print("RetweetTweet Failed: \(error)")
        })
    }
    
    
    @IBOutlet weak var favButton: UIButton!
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorite = !favorited
        if (toBeFavorite){
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("FavoriteTweet Failed: \(error)")
            })
        }else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("UnfavoriteTweet Failed: \(error)")
            })
            
        }
    }
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

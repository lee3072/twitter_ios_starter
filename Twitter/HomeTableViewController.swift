//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by 이승헌 on 28/01/2019.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    
    var tweet_array = [NSDictionary]()
    var number_of_tweet = 20
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load_initial_tweets()
        myRefreshControl.addTarget(self, action: #selector(load_initial_tweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        load_initial_tweets()
    }
    
    
    @objc func load_initial_tweets(){
        number_of_tweet = 10
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let parameters = ["count": number_of_tweet]
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: parameters, success: { (tweets: [NSDictionary]) in
            self.tweet_array.removeAll()
            for tweet in tweets {
                self.tweet_array.append(tweet)
            }
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
        }, failure: { (Error) in
            print("Could not recieve tweets!")
        })
    }
    
    func load_more_tweets(){
        number_of_tweet += 10
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let parameters = ["count": number_of_tweet]
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: parameters, success: { (tweets: [NSDictionary]) in
            self.tweet_array.removeAll()
            for tweet in tweets {
                self.tweet_array.append(tweet)
            }
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("Could not recieve tweets!")
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweet_array.count {
            load_more_tweets()
        }
    }
 
    
    @IBAction func logout_button_clicked(_ sender: Any) {
        TwitterAPICaller.client?.logout();
        UserDefaults.standard.set(false, forKey: "is_login")
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweet_cell", for: indexPath) as! TweetCell
        let user = tweet_array[indexPath.row]["user"] as! NSDictionary
        cell.name_label.text = user["name"] as? String
        cell.tweet_content_label.text = tweet_array[indexPath.row]["text"] as? String
        
        
        let image_url = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: image_url!)
        
        if let image_data = data {
            cell.profile_image.image = UIImage(data: image_data)
        }
        
        cell.set_favorited(tweet_array[indexPath.row]["favorited"] as! Bool)
        cell.set_retweeted(tweet_array[indexPath.row]["retweeted"] as! Bool)
        cell.tweetId = tweet_array[indexPath.row]["id"] as! Int
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweet_array.count
    }


}

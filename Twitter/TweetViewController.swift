//
//  TweetViewController.swift
//  Twitter
//
//  Created by 이승헌 on 04/02/2019.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var text_view: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text_view.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel_button_clicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet_button_clicked(_ sender: Any) {
        if(!text_view.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: text_view.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet in \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

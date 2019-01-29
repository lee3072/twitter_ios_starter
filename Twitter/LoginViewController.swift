//
//  LoginViewController.swift
//  Twitter
//
//  Created by 이승헌 on 28/01/2019.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(UserDefaults.standard.bool(forKey: "is_login")){
            self.performSegue(withIdentifier: "login_to_home", sender: self)
        }
    }
    
    @IBAction func login_button_clicked(_ sender: Any) {
        
        let login_url = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: login_url, success: {
            UserDefaults.standard.set(true, forKey: "is_login")
            self.performSegue(withIdentifier: "login_to_home", sender: self)
        }, failure: { (Error) in
            print("Could Not Login")
        })
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

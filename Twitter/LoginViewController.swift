//
//  LoginViewController.swift
//  Twitter
//
//  Created by Yao on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func onLoginButton(_ sender: Any) {
        let authUrl = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: authUrl, success: {
            
            UserDefaults.standard.set(true,  forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "logInToHome", sender: self)
        }, failure: { (Error) in
            print("Could not login")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn")  == true {
            self.performSegue(withIdentifier: "logInToHome", sender: self)
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

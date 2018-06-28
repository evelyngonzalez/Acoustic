//
//  ViewController.swift
//  AppAcoustic
//
//  Created by Evelyn on 11/6/18.
//  Copyright © 2018 Evelyn. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginButton: GIDSignInButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Loging with Google
        GIDSignIn.sharedInstance().uiDelegate = self
        
        //Hidde navigation bar
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


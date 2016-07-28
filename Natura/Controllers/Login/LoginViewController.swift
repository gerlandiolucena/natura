//
//  LoginViewController.swift
//  Natura
//
//  Created by Gerlandio on 7/28/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var activityFacebook: UIActivityIndicatorView!
    var loginFinished = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFacebookBehavior()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if loginFinished {
            self.receivedProfile()
        }
    }
}

    //MARK: - Login actions

extension LoginViewController {
    
    @IBAction func loginWithFacebook(sender: AnyObject) {
        activityFacebook.startAnimating()
        FacebookLogin().fbSDKLogin(self) { (message, error) in
            self.activityFacebook.stopAnimating()
            if error == nil {
                self.loginFinished = true
            } else {
                AlertControllerUtil.showAlertOK(self, title: "Login com Facebook retornou um erro", message: "Não foi possível realizar o login com Facebook, tente novamente mais tarde.", handler: nil)
            }
        }
    }
    
}

    //MARK: - Facebook login

extension LoginViewController {
    
    func setupFacebookBehavior() {
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(receivedProfile), name:FBSDKProfileDidChangeNotification, object: nil)
    }
    
    func receivedProfile() {
        if FBSDKProfile.currentProfile() != nil {
            activityFacebook.stopAnimating()
            let name = FBSDKProfile.currentProfile().firstName
            let token = FBSDKAccessToken.currentAccessToken().tokenString
            let picture = FBSDKProfile.currentProfile().imageURLForPictureMode(.Normal, size: CGSizeMake(180.0, 180.0))
            let uid = FBSDKProfile.currentProfile().userID
            
            User.setupFacebookLogin(token, facebookUID: uid, picture: "\(picture)", name:name)
            performSegueWithIdentifier("loginHomeSegue", sender: nil)
        }
    }
}
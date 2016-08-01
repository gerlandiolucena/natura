//
//  UserFriendsListViewController.swift
//  Natura
//
//  Created by Gerlandio Lucena on 30/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit

import UIKit
import FBSDKLoginKit
import FBSDKShareKit

class UserFriendsListViewController: UIViewController {
    
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var invitableFriendsList: FriendsList?
    var usingFriendsList: FriendsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFacebookBehavior()
        loadUserFriendList()
    }
}

//MARK: - Table friend and contact list

extension UserFriendsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentSize = currentList()?.friendsList?.count ?? 0
        
        if currentSize <= 0 {
            labelMessage.hidden = true
        }
        
        return currentSize
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: identifier)
        }
        
        cell?.textLabel?.text = currentList()?.friendsList?[indexPath.row].name
        if let url = NSURL(string: currentList()?.friendsList?[indexPath.row].pictureURL ?? "") {
            cell?.imageView?.af_setImageWithURL(url)
        }
        cell?.detailTextLabel?.text = currentList()?.friendsList?[indexPath.row].email
        
        return cell!
    }
}

//MARK: Load friend list table

extension UserFriendsListViewController {
    
    func loadUserFriendList() {
        guard let _ = FBSDKAccessToken.currentAccessToken().tokenString else {
            FacebookLogin().fbSDKLogin(self) { (message, error) in
                if error == nil {
                    FacebookLogin().fbSDKFriendsOnApp()
                    FacebookLogin().fbSDKInvitibleFriends()
                } else {
                    AlertControllerUtil.showAlertOK(self, title: "Login com Facebook retornou um erro", message: "Não foi possível realizar o login com Facebook, tente novamente mais tarde.", handler: nil)
                }
            }
            return
        }
        
        FacebookLogin().fbSDKFriendsOnApp()
        FacebookLogin().fbSDKInvitibleFriends()
    }
    
    func currentList() -> FriendsList? {
        if segmentedControl.selectedSegmentIndex == 1 {
            return usingFriendsList
        }
        
        return invitableFriendsList
    }
}

    //MARK: - Facebook login

extension UserFriendsListViewController {
    
    func setupFacebookBehavior() {
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(receivedProfile), name:FBSDKProfileDidChangeNotification, object: nil)
        listenTo(NotificationBase.FacebookInApp, call: #selector(loadFrientsOnApp(_:)))
        listenTo(NotificationBase.FacebookInvitableFriends, call: #selector(loadInvitableFriends(_:)))
    }
    
    func receivedProfile() {
        if FBSDKProfile.currentProfile() != nil {
            let name = FBSDKProfile.currentProfile().firstName
            let token = FBSDKAccessToken.currentAccessToken().tokenString
            let picture = FBSDKProfile.currentProfile().imageURLForPictureMode(.Normal, size: CGSizeMake(180.0, 180.0))
            let uid = FBSDKProfile.currentProfile().userID
            
            User.setupFacebookLogin(token, facebookUID: uid, picture: "\(picture)", name:name)
            loadUserFriendList()
        }
    }
    
    func loadFrientsOnApp(sender: NSNotification?) {
        if let friendListObject = sender?.object as? FriendsList {
            usingFriendsList = friendListObject
            if usingFriendsList?.friendsList?.count <= 0 {
                labelMessage.hidden = false
            } else {
                tableView.reloadData()
            }
        }
    }
    
    func loadInvitableFriends(sender: NSNotification?) {
        if let friendListObject = sender?.object as? FriendsList {
            invitableFriendsList = friendListObject
            if invitableFriendsList?.friendsList?.count <= 0 {
                labelMessage.hidden = true
            }
        }
    }
}

    //MARK: - ViewController Actions
extension UserFriendsListViewController {
    
    @IBAction func segmentedControlChanged(sender: AnyObject) {
        tableView.reloadData()
    }
    
    @IBAction func dismissViewController(sender: AnyObject) {
        dismissViewController(true)
    }
}

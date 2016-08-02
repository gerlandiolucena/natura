//
//  UserFriendsListViewController.swift
//  Natura
//
//  Created by Gerlandio Lucena on 30/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class UserFriendsListViewController: UIViewController {
    
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var invitableFriendsList: FriendsList?
    var usingFriendsList: FriendsList?
    var usersSelected = [String]()
    
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
        
        labelMessage.hidden = true
        
        if currentSize <= 0 {
            labelMessage.hidden = false
        }
        
        return currentSize
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        
        if let cellUser = cell as? UserImageCell, userFacebook = currentList()?.friendsList?[indexPath.row] {
            cellUser.facebookFriend = userFacebook
            cellUser.accessoryType = userSelected(userFacebook) ? .Checkmark : .None
            return cellUser
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var acessoryType = UITableViewCellAccessoryType.None
        
        if let userFacebook = currentList()?.friendsList?[indexPath.row] {
            if userSelected(userFacebook) == false {
                usersSelected.append(userFacebook.id!)
                acessoryType = .Checkmark
            } else if let index = usersSelected.indexOf({$0 == userFacebook.id}){
                usersSelected.removeAtIndex(index)
            }
        }
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = acessoryType
        }
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
            labelMessage.hidden = true
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
            labelMessage.hidden = true
            if invitableFriendsList?.friendsList?.count <= 0 {
                labelMessage.hidden = false
            } else {
                tableView.reloadData()
            }
        }
    }
    
    func userSelected(userFacebook: UserFacebook) -> Bool {
        if usersSelected.contains({ $0 == userFacebook.id }) {
            return true
        }
        
        return false
    }
}

    //MARK: - ViewController Actions

extension UserFriendsListViewController {
    
    @IBAction func segmentedControlChanged(sender: AnyObject) {
        usersSelected = [String]()
        tableView.reloadData()
    }
    
    @IBAction func dismissController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func selectedFriends() {
        var listOfFriends = [UserFacebook]()
        
        for idUser in usersSelected {
            if let userFriend = currentList()?.friendsList?.filter({$0.id == idUser}).first {
                listOfFriends.append(userFriend)
            }
        }
        
        NotificationBase.SelectFriends.notifyWithObject(listOfFriends)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

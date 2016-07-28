//
//  User.swift
//  Natura
//
//  Created by Gerlandio Lucena on 26/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit
import FBSDKLoginKit

var currentUser = User()

class User: Mappable {

    var name: String?
    var email: String?
    var uid: String?
    var token: String?
    var deviceToken: String?
    var address: String?
    var authenticationToken: String?
    var id: Int?
    var invitedFriends: Int? = 0
    var profilePicture180: String?
    var age: Int?
    
    required init(map: Mapper) throws {
        name = map.optionalFrom("name")
        email = map.optionalFrom("email")
        uid = map.optionalFrom("uid")
        token = map.optionalFrom("app_token")
        deviceToken = map.optionalFrom("deviceToken")
        address = map.optionalFrom("address")
        authenticationToken = map.optionalFrom("authentication_token")
        id = map.optionalFrom("id")
        invitedFriends = map.optionalFrom("invited_friends")
        profilePicture180 = map.optionalFrom("profile_picture_180")
        age = map.optionalFrom("age")
        
        currentUser = self
    }
    
    init() {
        name = NSUserDefaults.standardUserDefaults().stringForKey("name")
        email = NSUserDefaults.standardUserDefaults().stringForKey("email")
        uid = NSUserDefaults.standardUserDefaults().stringForKey("uid")
        token = NSUserDefaults.standardUserDefaults().stringForKey("token")
        deviceToken = NSUserDefaults.standardUserDefaults().stringForKey("deviceToken")
    }
    
    func saveUserState() {
        NSUserDefaults.standardUserDefaults().setValue(name, forKeyPath: "name")
        NSUserDefaults.standardUserDefaults().setValue(email, forKeyPath: "email")
        NSUserDefaults.standardUserDefaults().setValue(uid, forKeyPath: "uid")
        NSUserDefaults.standardUserDefaults().setValue(token, forKeyPath: "token")
        NSUserDefaults.standardUserDefaults().setValue(deviceToken, forKeyPath: "deviceToken")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func logout() {
        FBSDKLoginManager().logOut()
        NSUserDefaults.standardUserDefaults().removeObjectForKey("name")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("email")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("uid")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("token")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("deviceToken")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func sharedInstance() -> User {
        return currentUser
    }
    
    
    class func setupFacebookLogin(facebookToken: String, facebookUID: String, picture: String, name: String) {
        currentUser.authenticationToken = facebookToken
        currentUser.uid = facebookUID
        currentUser.name = name
        currentUser.profilePicture180 = picture
    }
}

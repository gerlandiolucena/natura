//
//  UserFacebook.swift
//  Natura
//
//  Created by Gerlandio Lucena on 26/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit

class UserFacebook: Mappable {
    
    var lastName: String?
    var firstName: String?
    var id: String?
    var name: String?
    var email: String?
    var pictureURL: String?
    
    required init(map: Mapper) throws {
        lastName = map.optionalFrom("last_name")
        email = map.optionalFrom("email")
        firstName = map.optionalFrom("first_name")
        name = map.optionalFrom("name")
        id = map.optionalFrom("id")
        pictureURL = map.optionalFrom("picture.data.url")
    }
}

class FriendsList: Mappable {
    
    var friendsList: [UserFacebook]?
    
    required init(map: Mapper) throws {
        friendsList = map.optionalFrom("data")
    }
}

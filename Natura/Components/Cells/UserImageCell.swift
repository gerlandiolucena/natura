//
//  UserImageCell.swift
//  Natura
//
//  Created by Gerlandio on 8/1/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit

class UserImageCell: UITableViewCell {
    
    
    @IBOutlet weak var imageFriend: UIImageView!
    @IBOutlet weak var userFriend: UILabel!
    
    var facebookFriend: UserFacebook? {
        didSet{
            fillUserCell()
        }
    }
    
    func fillUserCell() {

        userFriend?.text = facebookFriend?.name
    
        if let url = NSURL(string: facebookFriend?.pictureURL ?? "") {
            imageFriend.af_setImageWithURL(url)
        }
    }
}

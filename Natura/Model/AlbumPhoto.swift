//
//  AlbumPhoto.swift
//  Natura
//
//  Created by Gerlandio Lucena on 26/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit

class AlbumPhoto: Mappable {
    
    var is_default: String?
    var location: String?
    var message: String?
    var name: String?
    var place: String?
    var privacy: String?
    var id: String?
    
    required init(map: Mapper) throws {
        is_default = map.optionalFrom("is_default")
        location = map.optionalFrom("location")
        message = map.optionalFrom("message")
        name = map.optionalFrom("name")
        place = map.optionalFrom("place")
        privacy = map.optionalFrom("privacy")
        id = map.optionalFrom("id")
    }
}

class AlbumsList: Mappable {
    
    var albums: [AlbumPhoto]?
    
    required init(map: Mapper) throws {
        albums = map.optionalFrom("data")
    }
}

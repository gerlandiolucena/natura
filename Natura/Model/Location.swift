//
//  Location.swift
//  Natura
//
//  Created by Gerlandio Lucena on 27/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit

class Location: Mappable {
    
    var lat: Double?
    var lng: Double?
    
    required init(map: Mapper) throws {
        lat = map.optionalFrom("lat")
        lng = map.optionalFrom("lng")
    }
}

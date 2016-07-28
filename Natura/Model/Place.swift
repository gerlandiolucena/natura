//
//  Place.swift
//  Natura
//
//  Created by Gerlandio Lucena on 27/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit

class Place: Mappable {
    
    var geometry: Location?
    var icon: String?
    var id: String?
    var name: String?
    var place_id: String?
    var reference: String?
    var scope: String?
    var types: [String]?
    var vicinity: String?
    
    required init(map: Mapper) throws {
        geometry = map.optionalFrom("geometry.location")
        icon = map.optionalFrom("icon")
        id = map.optionalFrom("id")
        name = map.optionalFrom("name")
        place_id = map.optionalFrom("place_id")
        reference = map.optionalFrom("reference")
        scope = map.optionalFrom("scope")
        types = map.optionalFrom("types")
        vicinity = map.optionalFrom("vicinity")
    }
}

class Places: Mappable {
    
    var places: [Place]?
    
    required init(map: Mapper) throws {
        places = map.optionalFrom("results")
    }
}
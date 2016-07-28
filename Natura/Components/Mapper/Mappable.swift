//
//  Mappable.swift
//  Natura
//
//  Created by Gerlandio Lucena at 27/07/2016
//  Copyright © 2016 Natura. All rights reserved.
//

import Foundation

public protocol Mappable {
    /**
     Define how your custom object is created from a Mapper object
     */
    init(map: Mapper) throws

    /**
     Convenience method for creating Mappable objects from NSDictionaries

     - parameter JSON: The JSON to create the object from

     - returns: The object if it could be created, nil if creating the object threw an error
     */
}
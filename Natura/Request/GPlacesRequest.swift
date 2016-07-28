//
//  GPlacesRequest.swift
//  Natura
//
//  Created by Gerlandio Lucena on 27/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit

class GPlacesRequest: RequestBase {
    
    init() {
        let stringURL = Endpoints().googleMapsPlaces
        super.init(url: stringURL)
    }

    func getPlacesNear(location: String, type: String, callback: defaultResponse) {
        get(["location": location, "type": type, "key": APIKeys().googlePlacesApi,"rankby":"distance"]).response { (request, response, data, error) in
            
            do{
                let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data ?? NSData(), options: NSJSONReadingOptions.AllowFragments)
                
                if let dictionary = jsonResponse as? [String: AnyObject] {
                    let listOfPlaces = try Places(map: Mapper(json:dictionary))
                    callback(response: listOfPlaces, error: nil)
                }
                
            }catch let error as NSError {
                callback(response: "Não foi possível consultar os locais próximos a você.", error: error.description)
            }
        }
    }
}

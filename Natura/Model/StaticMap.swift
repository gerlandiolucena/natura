//
//  StaticMap.swift
//  Natura
//
//  Created by Gerlandio Lucena on 30/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit

class StaticMap: NSObject {
    
    var center = ""
    var zoom = 16
    var width = 144
    var height = 144
    var markerLabel = ""
    
    func defaultParameters(apiKey: String) -> String {
        var parameters = "center="+center
        parameters = "\(parameters)&zoom=\(zoom)"
        parameters = "\(parameters)&size=\(width)x\(height)"
        parameters = "\(parameters)&markers=color:blue|label:A|\(center)"
        parameters = "\(parameters)&key=\(apiKey)"
        parameters = "\(parameters)&maptype=roadmap"
        
        return parameters
    }
}

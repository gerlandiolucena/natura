//
//  NTAnnotation.swift
//  Natura
//
//  Created by Gerlandio Lucena on 27/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import Foundation
import MapKit

class NTAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var placeModel: Place
    
    init(annotationCoordinate: CLLocationCoordinate2D, titleString: String, place: Place) {
        coordinate = annotationCoordinate
        placeModel = place
        title = titleString
    }
}


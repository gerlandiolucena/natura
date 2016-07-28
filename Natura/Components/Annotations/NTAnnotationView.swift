//
//  NTAnnotationView.swift
//  Natura
//
//  Created by Gerlandio Lucena on 27/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import Foundation
import MapKit
import AlamofireImage

class NTAnnotationView: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

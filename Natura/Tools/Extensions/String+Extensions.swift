//
//  String+Extensions.swift
//  Natura
//
//  Created by Gerlandio Lucena on 28/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit

extension String {
    func notify() {
        NSNotificationCenter.defaultCenter().postNotificationName(self, object: nil)
    }
    
    func notifyWithObject(object: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(self, object: object)
    }
}

extension NSObject {
    func listenTo(notificationName: String, call selector: Selector) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: selector, name: notificationName, object: nil)
    }
    
    func stopListening(notificationName: String) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: notificationName, object: nil)
    }
}

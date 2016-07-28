//
//  AlertControllerUtil.swift
//  Natura
//
//  Created by Gerlandio Lucena on 28/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit

class AlertControllerUtil: NSObject {
    
    typealias handlerAction = ((action: UIAlertAction) -> Void)
    
    class func showAlertOK(forView: UIViewController, title: String, message: String, handler: handlerAction?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        addAction(alertController, title: "Ok", handler: handler, style: .Default)
        forView.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class func showAlertConfirmation(forView: UIViewController, title: String, message: String, confirmationTitles: [String]?, confirmationHandler: [handlerAction]?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        var style = UIAlertActionStyle.Default
        if let titles = confirmationTitles, handlers = confirmationHandler where titles.count == handlers.count {
            for (actionTitle, handlerAction) in zip(titles,handlers) {
                addAction(alertController, title: actionTitle, handler: handlerAction, style: style)
                style = .Cancel
            }
        }
        
        forView.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private class func addAction(alertController: UIAlertController, title: String, handler: handlerAction?, style: UIAlertActionStyle?) {
        let defaultAction = UIAlertAction(title: title, style: style ?? .Default, handler:handler)
        alertController.addAction(defaultAction)
    }
}

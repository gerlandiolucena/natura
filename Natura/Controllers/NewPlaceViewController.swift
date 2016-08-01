//
//  NewPlaceViewController.swift
//  Natura
//
//  Created by Gerlandio Lucena on 30/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit
import MapKit
import AlamofireImage

class NewPlaceViewController: UIViewController {

    var location: CLLocationCoordinate2D?
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeDescription: UITextField!
    @IBOutlet weak var friendListText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupLocationStaticMap()
    }
}

    //MARK: - ViewController Actions

extension NewPlaceViewController {
    @IBAction func dismissMe(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}


    //MARK: - TextField Delegate
extension NewPlaceViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == friendListText {
            performSegueWithIdentifier("newPlaceFriendsList", sender: nil)
        }
    }
}


    //MARK: - SetupView
extension NewPlaceViewController {
    
    func setupLocationStaticMap() {
        let staticMap = StaticMap()
        staticMap.center = "\(location?.latitude ?? 0.0),\(location?.longitude ?? 0.0)"
        staticMap.width = Int(UIScreen.mainScreen().bounds.size.width) - 32
        staticMap.zoom = 20
        staticMap.markerLabel = "A"
        if let url = NSURLComponents(string: Endpoints().googleStaticMaps) {
            url.query = staticMap.defaultParameters(APIKeys().googlePlacesApi)
            mapImage.af_setImageWithURL(url.URL!)
        }
    }
}

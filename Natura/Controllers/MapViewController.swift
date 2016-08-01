//
//  RootViewController.swift
//  Natura
//
//  Created by Gerlandio Lucena on 27/07/16.
//  Copyright © 2016 natura. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {

    @IBOutlet weak var 	mapView: MKMapView!
    let locationManager = CLLocationManager()
    var lastKnownLocation = CLLocationCoordinate2D()
    var typeFilter = PlacesTypesEnum.Restaurant.nameOption()
    var userChangedMap = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationListener()
        listenTo(NotificationBase.FilteredPlaces, call: #selector(filterReceived))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

    //MARK: - Setups and main requests

extension MapViewController {

    func requestPlaces(location: String) {
        GPlacesRequest().getPlacesNear(location, type: typeFilter) { (response, error) in
            //Oque fazer
            if self.mapView.annotations.count > 0 {
                self.mapView.removeAnnotations(self.mapView.annotations)
            }
            
            if let places = response as? Places where error == nil {
                for place in places.places ?? [Place]() {
                    let coordinates = CLLocationCoordinate2D(latitude: place.geometry?.lat ?? 0.0, longitude: place.geometry?.lng ?? 0.0)
                    let annotation = NTAnnotation(annotationCoordinate: coordinates, titleString: place.name ?? "", place: place)
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    func setupLocationListener() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 500
        locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction func showFilter(sender: AnyObject) {
        performSegueWithIdentifier("homeFilterSegue", sender: nil)
    }
    
    func filterReceived(type: AnyObject) {
        if let notification = type as? NSNotification, indexValue = notification.object as? Int {
            typeFilter = PlacesTypesEnum(rawValue: indexValue)?.nameOption() ?? ""
        }
        
        let stringLocation = "\(lastKnownLocation.latitude), \(lastKnownLocation.longitude)"
        requestPlaces(stringLocation)
    }
}

    //MARK: - Location delegates

extension MapViewController: CLLocationManagerDelegate {

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            lastKnownLocation = location.coordinate
            let stringLocation = "\(lastKnownLocation.latitude), \(lastKnownLocation.longitude)"
            requestPlaces(stringLocation)
            zoomInLocation(location)
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func zoomInLocation(location: CLLocation) {
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        mapView.setRegion(MKCoordinateRegionMake(location, span), animated: false)
    }
}

    //MARK: - Map interactions

extension MapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var imageAnnotation = mapView.dequeueReusableAnnotationViewWithIdentifier("ntAnnotation")
        
        if imageAnnotation == nil {
            imageAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: "ntAnnotation")
        }
        
        imageAnnotation?.canShowCallout = true
        
        if let placeAnnotation = annotation as? NTAnnotation {
            if let url = NSURL(string: placeAnnotation.placeModel.icon ?? "") {
                let imageView = UIImageView()
                imageView.af_setImageWithURL(url)
                imageView.frame = CGRectMake(0.0, 0.0, 30.0, 30.0)
                for view in imageAnnotation?.subviews ?? [UIView]() {
                    view.removeFromSuperview()
                }
                imageAnnotation?.addSubview(imageView)
                imageAnnotation?.canShowCallout = true
                imageAnnotation?.enabled = true
                return imageAnnotation
            }
        }
        return imageAnnotation!
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if(fromUserInteration()) {
            let stringLocation = "\(mapView.centerCoordinate.latitude), \(mapView.centerCoordinate.longitude)"
            requestPlaces(stringLocation)
        }
    }
    
    private func fromUserInteration() -> Bool {
        if let subView = self.mapView.subviews.first {
            if let gesture = subView.gestureRecognizers, _ = gesture.filter({$0.state == .Began || $0.state == .Ended }).first {
                return true
            }
        }
        
        return false
    }
    
    @IBAction func longPressOnMap(recognizer: UIGestureRecognizer){
        if (recognizer.state == .Began) {
            let touchPoint = recognizer.locationInView(self.mapView)
            let coordinate = self.mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
            self.performSegueWithIdentifier("mapAddPlaceSegue", sender: ["latitude": coordinate.latitude, "longitude": coordinate.longitude])
        }
    }
}

    //MARK: - Navigation actions

extension MapViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? NewPlaceViewController {
            guard let dictLocation = sender as? NSDictionary else {
                return
            }
            
            if let latitude = dictLocation["latitude"] as? Double, longitude = dictLocation["longitude"] as? Double {
                destination.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
        }
    }
}

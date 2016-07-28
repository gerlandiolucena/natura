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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationListener()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MapViewController {

    func requestPlaces(location: String) {
        GPlacesRequest().getPlacesNear(location, type: "restaurant") { (response, error) in
            //Oque fazer
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
}

extension MapViewController: CLLocationManagerDelegate {

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //TODO: Change Location
        
        if let location = locations.first {
            let stringLocation = "\(location.coordinate.latitude), \(location.coordinate.longitude)"
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
                imageAnnotation?.addSubview(imageView)
                imageAnnotation?.canShowCallout = true
                return imageAnnotation
            }
        }
        return imageAnnotation!
    }
}
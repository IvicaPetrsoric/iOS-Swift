//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var movedToUserLocation = false
    
    //    Rijeka:
    //    Latitude:   45.328979,
    //    Longitude    14.457664
    
    override func viewDidLoad() {
        
        let keyboardDissapearr = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(keyboardDissapearr)
        
        let pinDropperenderer = UILongPressGestureRecognizer(target: self, action: #selector(dropAnnotation))
        pinDropperenderer.minimumPressDuration = CFTimeInterval(1.0)
        mapView.addGestureRecognizer(pinDropperenderer)
        
        mapView.delegate   = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    @objc func dropAnnotation(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let holdLocation = gestureRecognizer.location(in: mapView)
            let coor = mapView.convert(holdLocation, toCoordinateFrom: mapView)
            
            let annotatioView: MKAnnotationView!
            let pointAnnotation = MKPointAnnotation()
            
            pointAnnotation.coordinate = coor
            pointAnnotation.title = "\(coor.latitude) \(coor.longitude)"
            
            annotatioView = MKAnnotationView(annotation: pointAnnotation, reuseIdentifier: "Annotation2")
            mapView.addAnnotation(annotatioView.annotation!)
            
            latitudeTextField.text = "\(coor.latitude)"
            longitudeTextField.text = "\(coor.longitude)"
        }
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    func clearMap() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays) // roots
    }
    
    @IBAction func navigate(_ sender: UIButton) {
        dissmissKeyboard()
        clearMap()
        
        if let latitudeText = latitudeTextField.text, let longitudeText = longitudeTextField.text {
            if latitudeText != "" && longitudeText != "" {
                if let lat = Double(latitudeText), let lon = Double(longitudeText) {
                    let coor = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    
                    let annotationView: MKPinAnnotationView!
                    let annotationPoint = MKPointAnnotation()
                    
                    annotationPoint.coordinate = coor
                    annotationPoint.title = "\(lat) \(lon)"
                    
                    annotationView = MKPinAnnotationView(annotation: annotationPoint, reuseIdentifier: "Annotation")
                    
                    mapView.addAnnotation(annotationView.annotation!)
                    
                    let directionsRequest = MKDirections.Request()
                    
                    directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
                    directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: coor))
                    directionsRequest.requestsAlternateRoutes = true
                    directionsRequest.transportType = .automobile
                    
                    let directions = MKDirections(request: directionsRequest)
                    directions.calculate(completionHandler: { (response, error) in
                        if let response = response {
                            
                            //                            if let routes = response.routes {
                            if let routes = response.routes.first {
                                
                                //                                mapView.addOverlays(routes)
                                self.mapView.addOverlay(routes.polyline)
                                
                                self.mapView.region.center = coor
                            }
                            
                        } else {
                            print(error as Any)
                        }
                    })
                }
            }
        }
    }
    
    
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status.hashValue)
        switch status {
        case .denied, .restricted:
            print("Denied")
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            
        case .authorizedAlways:
            manager.startUpdatingLocation()
            
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if !movedToUserLocation {
            movedToUserLocation = true
            
            mapView.region.center = mapView.userLocation.coordinate
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        renderer.lineWidth = 5.0
        
        return renderer
    }
}



//
//  FirstViewController.swift
//  PoolParty
//
//  Created by Nicholas Allen on 6/5/19.
//  Copyright © 2019 Allen Application Design. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
import Firebase

class DriverViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    let locationManager = CLLocationManager()
    
    var currentLocation = CLLocationCoordinate2D()
    var destLat = 0.0
    var destLon = 0.0
    
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 6.0))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view = mapView
        
        let origin = "\(37.5357629),\(-77.4355607)"
        let destination = "\(37.6279917),\(-77.6725502)"
        
        //Draw route
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyAw8wS-jnHVHIWj30YDpN6nlZCgt1-Sgp8"
        
        //Rrequesting Alamofire and SwiftyJSON
        Alamofire.request(url).responseJSON { response in
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result)   // result of response serialization
            
            do {
            let json =  try JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline(path: path)
                polyline.strokeColor = UIColor.blue
                polyline.strokeWidth = 2
                polyline.map = self.mapView
            }
            } catch let error as NSError {
                return
            }
        }
        
        let marker1 = GMSMarker();
        marker1.position = CLLocationCoordinate2D(latitude: 37.619539, longitude: -77.57414919)
        marker1.title = "Destination: West Creek Town Center"
        marker1.snippet = "(717) 836-8628"
        marker1.icon = UIImage(named: "personpin")
        marker1.map = mapView
        
        let marker2 = GMSMarker();
        marker2.position = CLLocationCoordinate2D(latitude: 37.6431611, longitude: -77.5427165)
        marker2.title = "Destination: West Creek 3"
        marker2.snippet = "(937) 325-7268"
        marker2.icon = UIImage(named: "personpin")
        marker2.map = mapView
        
        let marker3 = GMSMarker();
        marker3.position = CLLocationCoordinate2D(latitude: 37.6119661, longitude: -77.5293403)
        marker3.title = "Destination: Billy Jack's Shack, Cary St"
        marker3.snippet = "(717) 836-8628"
        marker3.icon = UIImage(named: "personpin")
        marker3.map = mapView
        
        let startMarker = GMSMarker();
        startMarker.position = CLLocationCoordinate2D(latitude: 37.5357629, longitude: -77.4355607)
        startMarker.icon = GMSMarker.markerImage(with: UIColor.blue)
        startMarker.map = mapView
        
        let endMarker = GMSMarker();
        endMarker.position = CLLocationCoordinate2D(latitude: 37.6279917, longitude: -77.6725502)
        endMarker.icon = GMSMarker.markerImage(with: UIColor.green)
        endMarker.map = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //locationManager.delegate = self
        //locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        self.currentLocation = location.coordinate
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
}


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
    
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 6.0))
    
    override func loadView() {
        super.loadView()
        
        view = mapView
        
        let origin = "\(32.776665),\(-96.796989)"
        let destination = "\(39.180430),\(-96.557290)"
        
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
    
    func getNearbyUsers(src: String, dest: String) -> [[String]] {
        let db = Firestore.firestore()
        let dur = calculateRouteDuration(src: src,dest: dest,waypts: "")
        var arr = [[String]]()
        
        let waypts = "";
        db.collection("Users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print ("Error")
            } else {
                for document in querySnapshot!.documents {
                    waypts += document.data()["source"] + "|" + document.data()["destination"]
                    
                    let new_dur = self.calculateRouteDuration(src: src, dest: dest, waypts: waypts)
                    
                    if new_dur - dur <= 300 {
                        arr[0][0] = src
                        arr[0][1] = dest
                    }
                    
                    
                }
            }
        }
        
        return arr
        
    }
    
    func calculateRouteDuration(src: String, dest: String, waypts: String) -> Int {
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(src)&destination=\(dest)&mode=driving&key=ADD_KEY_HERE&waypoints=\(waypts)"
        
        //Rrequesting Alamofire and SwiftyJSON
        Alamofire.request(url).responseJSON { response in
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result)   // result of response serialization
            
            do {
            let json = try JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            var legs = routes[0]["legs"]
            
            let routeDur = 0
            for leg in legs
            {
                let routeDuration = legs["duration"].dictionary
                let duration_value = routeDuration?[value]
                
                routeDur += duration_value
            }
                return routeDur }
            catch let error as NSError {
                return
            }
        }
    }
}


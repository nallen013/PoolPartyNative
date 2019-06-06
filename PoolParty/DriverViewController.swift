//
//  FirstViewController.swift
//  PoolParty
//
//  Created by Nicholas Allen on 6/5/19.
//  Copyright © 2019 Allen Application Design. All rights reserved.
//

import UIKit
import GoogleMaps

class DriverViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


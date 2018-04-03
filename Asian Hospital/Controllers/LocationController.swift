//
//  LocationController.swift
//  Asian Hospital
//
//  Created by HopprLab on 28/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import UIKit
import MapKit

class LocationController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ACTIONS
    
    @IBAction func showLocation() {
        let coordinates = CLLocationCoordinate2DMake(coordinateData.latitude, coordinateData.longitude)
        let regionDistance: CLLocationDistance = 1000
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Asian Hospital and Medical Center"
        mapItem.openInMaps(launchOptions: options)
    }
}

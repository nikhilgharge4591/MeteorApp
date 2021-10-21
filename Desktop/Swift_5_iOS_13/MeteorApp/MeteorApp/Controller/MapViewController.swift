//
//  MapViewController.swift
//  MeteorApp
//
//  Created by Ishmeet Singh Sethi on 2021-10-21.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var meteor: Meteor!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        mapView.delegate = self
        let annotation = MeteorAnnotation(meteor: self.meteor)
        mapView.addAnnotation(annotation)
        mapView.centerCoordinate = annotation.coordinate
    }
}


extension MapViewController: MKMapViewDelegate {
    
}

//
//  CountryDetailsViewController.swift
//  Countrywise-Indoorway
//
//  Created by Peter Kowalski on 02/05/2019.
//  Copyright © 2019 Peter Kowalski. All rights reserved.
//

import UIKit
import MapKit

class CountryDetailsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var initialLocation: CLLocation!
    var mkSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        centerMapOnLocation(location: initialLocation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, span: mkSpan)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func didPressBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

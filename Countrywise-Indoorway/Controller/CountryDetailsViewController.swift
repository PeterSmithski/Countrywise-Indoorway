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

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var demonymLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var nativeLabel: UILabel!
    
    var country: Country!
    let notAvailable = "Not Available"
    var mkSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = country.name
        if(country.demonym.isEmpty){
            demonymLabel.text = notAvailable
        }else{
            demonymLabel.text = country.demonym
        }
        if(country.capital.isEmpty){
            capitalLabel.text = notAvailable
        }else{
            capitalLabel.text = country.capital
        }
        if(country.region.isEmpty){
            regionLabel.text = notAvailable
        }else{
            regionLabel.text = country.region
        }
        populationLabel.text = String(country.population)
        if(country.nativeName.isEmpty){
            nativeLabel.text = notAvailable
        }else{
            nativeLabel.text = country.nativeName
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        centerMapOnLocation(location: country.initialLocation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, span: mkSpan)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func didPressBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

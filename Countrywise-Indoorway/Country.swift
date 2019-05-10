//
//  File.swift
//  Countrywise-Indoorway
//
//  Created by Peter Kowalski on 07/05/2019.
//  Copyright © 2019 Peter Kowalski. All rights reserved.
//

import UIKit
import MapKit

class Country{
    
    let name: String
    let alpha2Code: String
    let image: UIImage
    let initialLocation: CLLocation
   
    init(name: String, alpha2Code: String, lat: Double, lng: Double, image: UIImage){
        self.name = name
        self.alpha2Code = alpha2Code
        self.image = image
        self.initialLocation = CLLocation(latitude: lat, longitude: lng)
    }
    
}

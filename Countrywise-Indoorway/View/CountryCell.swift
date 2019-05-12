//
//  CountryCell.swift
//  Countrywise-Indoorway
//
//  Created by Peter Kowalski on 02/05/2019.
//  Copyright © 2019 Peter Kowalski. All rights reserved.
//

import UIKit

class CountryCell: UICollectionViewCell {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    
    func configure(name: String, image: UIImage){
        self.countryLabel.text = name
        self.countryImage.contentMode = UIView.ContentMode.center
        self.countryImage.image = image
        self.countryImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.isUserInteractionEnabled = true
    }
    
    override func prepareForReuse() {
        countryLabel.text = nil
        countryImage.image = nil
    }
}


//
//  CountryListViewController.swift
//  Countrywise-Indoorway
//
//  Created by Peter Kowalski on 30/04/2019.
//  Copyright © 2019 Peter Kowalski. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class CountryListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var findCountrySearchBar: UISearchBar!
    
    var countries = [Country]()
    var filteredCountries = [Country]()
    var location: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findCountrySearchBar.delegate = self
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = true
        filteredCountries = countries
    }
  
    
    
}
    //MARK - Handling and filtering data
    /*****************************************************/

extension CountryListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCell", for: indexPath) as? CountryCell else {
            return UICollectionViewCell()
        }
        cell.configure(name: filteredCountries[indexPath.item].name, image: filteredCountries[indexPath.item].image)        
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        location = filteredCountries[indexPath.item].initialLocation
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            let mapVC = segue.destination as! CountryDetailsViewController
            mapVC.initialLocation = location
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCountries = searchText.isEmpty ? countries : countries.filter{ $0.name.contains (searchText) }
        collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.findCountrySearchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredCountries = countries
        findCountrySearchBar.text = ""
        findCountrySearchBar.showsCancelButton = false
        findCountrySearchBar.resignFirstResponder()
        collectionView.reloadData()
    }
    
}

    
    


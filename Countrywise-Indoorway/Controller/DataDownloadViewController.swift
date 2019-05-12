//
//  DataDownloadViewController.swift
//  Countrywise-Indoorway
//
//  Created by Peter Kowalski on 09/05/2019.
//  Copyright © 2019 Peter Kowalski. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DataDownloadViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    var downloadedCountries = [Country]()
    var countryJSON: JSON?
    var numberOfCountries: Int = 0
    var downloadSucces: Bool = false
    var tempImage = UIImage()
    
    let queue = DispatchQueue(label: "progress-queue", qos: .background)
    
    let FLAGS_START_URL = "https://www.countryflags.io/"        // API for flag displaying
    let FLAGS_END_URL = "/shiny/64.png"
    let COUNTRIES_URL = "https://restcountries.eu/rest/v2/all"  // provided API
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryCount(url: COUNTRIES_URL)
        progressView.setProgress(0.0, animated: false)
    }
    
    //MARK: - Networking and parsing data
    /*****************************************************/
    
    func getCountryCount(url: String){
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess{
                self.countryJSON = JSON(response.result.value!)
                self.numberOfCountries = self.countryJSON!.count
                self.downloadSucces = true
                self.getCountryData(url: url)
            }else{
                self.downloadSucces = false
                self.numberOfCountries = 0
                self.infoLabel.text = "Woops! Connection problems :("
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    func getCountryData(url: String) -> Bool{
        if(self.downloadSucces){
            for index in 0 ... self.numberOfCountries - 1{
                queue.async(){
                    self.downloadedCountries.append(Country.init(name: self.countryJSON![index]["name"].string!,
                                                                 cap: self.countryJSON![index]["capital"].string!,
                                                                 reg: self.countryJSON![index]["subregion"].string!,
                                                                 dem: self.countryJSON![index]["demonym"].string!,
                                                                 pop: self.countryJSON![index]["population"].int!,
                                                                 native: self.countryJSON![index]["nativeName"].string!,
                                                                 alpha2Code: self.countryJSON![index]["alpha2Code"].string!,
                                                                 lat: self.countryJSON![index]["latlng"][0].double ?? 0,
                                                                 lng: self.countryJSON![index]["latlng"][1].double ?? 0,
                                                                 image: self.getImage(countryCode: self.countryJSON![index]["alpha2Code"].string!)))
                    DispatchQueue.main.async{
                        self.progressView.progress = (Float(index)/Float(self.numberOfCountries))
                        if(index == self.numberOfCountries - 1){
                            self.goToList()
                        }
                    }
                }
            }
        }
        return downloadSucces
    }

    func goToList(){
            performSegue(withIdentifier: "goToCountryListSegue", sender: self)
    }
    
    func getImage(countryCode: String) -> UIImage{
        let imageLink = FLAGS_START_URL + countryCode + FLAGS_END_URL
        if let downloadURL = NSURL(string: imageLink){
            if let data = NSData(contentsOf: downloadURL as URL){
                self.tempImage = UIImage(data: data as Data)!
            }
        }
        return tempImage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCountryListSegue"{
            let secondVC = segue.destination as! CountryListViewController
            secondVC.countries = downloadedCountries
        }
    }
}

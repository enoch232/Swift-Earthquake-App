//
//  ViewController.swift
//  earthquakeApp
//
//  Created by Enoch Ko on 3/26/17.
//  Copyright © 2017 asu. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {


    @IBOutlet weak var addressField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func searchAddress(_ sender: Any) {
        let geoCoder = CLGeocoder();
        let addressString = self.addressField.text!
        CLGeocoder().geocodeAddressString(addressString, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    let coords = location!.coordinate
                    print(coords.latitude)
                    print(coords.longitude)
                    let latitude = coords.latitude
                    let longitude = coords.longitude
                    let north = String(coords.latitude + 10)
                    let south = String(coords.latitude - 10)
                    let west = String(coords.longitude + 10)
                    let east = String(coords.longitude - 10)
                    
                    
                
                    let url = "http://api.geonames.org/earthquakesJSON?formatted=true&north="+north+"&south="+south+"&east="+east+"&west="+west+"&username=enoch232&style=full"
                    print(url)
                    
                }
        })
    }


}


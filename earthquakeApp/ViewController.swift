//
//  ViewController.swift
//  earthquakeApp
//
//  Created by Enoch Ko on 3/26/17.
//  Copyright © 2017 asu. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var earthquakesList: [Earthquake] = []

    @IBOutlet weak var tablelist: UITableView!
    @IBOutlet weak var addressField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tablelist.dataSource = self
        self.tablelist.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func searchAddress(_ sender: Any) {
        let geoCoder = CLGeocoder();
        let addressString = self.addressField.text!
        geoCoder.geocodeAddressString(addressString, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    let coords = location!.coordinate
                    print(coords.latitude)
                    print(coords.longitude)
                    let north = String(coords.latitude + 10)
                    let south = String(coords.latitude - 10)
                    let west = String(coords.longitude + 10)
                    let east = String(coords.longitude - 10)
                    
                    
                
                    let urlAsString = "http://api.geonames.org/earthquakesJSON?formatted=true&north="+north+"&south="+south+"&east="+east+"&west="+west+"&username=enoch232&style=full"
                    self.getJsonData(urlAsString: urlAsString)
                    
                    print("updated")
                    
                }
        })
    }
    
    func getJsonData(urlAsString: String) {
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            print(jsonResult["earthquakes"])
            let earthquakes = jsonResult["earthquakes"] as? [[String: Any]]
            for earthquake in earthquakes! {
                var eq = Earthquake(datetime: earthquake["datetime"]! as! String, depth: "\(earthquake["depth"]! as! Float)", eqid: earthquake["eqid"]! as! String, lat: "\(earthquake["lat"]! as! Float)", lng: "\(earthquake["lng"]! as! Float)", magnitude: "\(earthquake["magnitude"]! as! Float)", src: earthquake["src"]! as! String)
                self.earthquakesList.append(eq)
                
            }
            self.tablelist.reloadData()

            print(self.earthquakesList.count)

            
        })
        jsonQuery.resume()
        self.tablelist.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return earthquakesList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = "depth: \(earthquakesList[indexPath.row].depth), datetime: \(earthquakesList[indexPath.row].datetime)\neqid: \(earthquakesList[indexPath.row].eqid), lat: \(earthquakesList[indexPath.row].lat), lng: \(earthquakesList[indexPath.row].lng)\nmagnitude: \(earthquakesList[indexPath.row].magnitude), src: \(earthquakesList[indexPath.row].src) "
        cell.textLabel?.font = UIFont(name:"Avenir", size:15)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        return(cell)
    }
    

}


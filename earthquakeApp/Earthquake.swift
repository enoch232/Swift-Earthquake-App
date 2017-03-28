//
//  Earthquake.swift
//  earthquakeApp
//
//  Created by Enoch Ko on 3/27/17.
//  Copyright © 2017 asu. All rights reserved.
//

import Foundation

class Earthquake {
    var datetime:String
    var depth:String
    var eqid:String
    var lat:String
    var lng:String
    var magnitude:String
    var src:String
    
    init(datetime: String, depth: String, eqid:String, lat:String, lng:String, magnitude:String, src:String){
        self.datetime = datetime
        self.depth = depth
        self.eqid = eqid
        self.lat = lat
        self.lng = lng
        self.magnitude = magnitude
        self.src = src
    }
}

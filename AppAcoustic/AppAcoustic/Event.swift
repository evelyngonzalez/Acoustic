//
//  Event.swift
//  AppAcoustic
//
//  Created by Evelyn on 19/6/18.
//  Copyright © 2018 Evelyn. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import MapKit
import Firebase

class Event: Mappable {
    
    var name: String?
    var image: String?
    var address: String?
    var day: String?
    var time: String?
    var coords: Location?
 
    required init?(map: Map) {
        
    }
    
    init(name: String?, image: String?, address: String, day: String, time: String, coords: Location){
        self.name = name
        self.image = image
        self.address = address
        self.day = day
        self.time = time
        self.coords = coords
       
    }
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.image <- map ["image"]
        self.address <- map ["address"]
        self.day <- map ["day"]
        self.time <- map ["time"]
        self.coords <- map["coords"]
    }
}

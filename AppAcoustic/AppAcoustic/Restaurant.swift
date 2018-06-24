//
//  Restaurant.swift
//  
//
//  Created by Evelyn on 19/6/18.
//

import UIKit
import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import MapKit
import Firebase

class Restaurant: Mappable {
    
    var name: String?
    var image: String?
    var city: String?
    var address: String?
    var day: String?
    var time: String?
    var payment: String?
    var phone: String?
    var gallery: [Gallery]?
        
    required init?(map: Map) {
            
    }
        
    init(name: String?, image: String?, city: String, address: String, day: String,time:String?, payment: String, phone: String, gallery: [Gallery]){
            self.name = name
            self.image = image
            self.address = address
            self.city = city
            self.day = day
            self.time = time
            self.payment = payment
            self.phone = phone
            self.gallery = gallery
    }
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.image <- map ["image"]
        self.address <- map ["address"]
        self.city <- map ["city"]
        self.day <- map ["day"]
        self.time <- map ["time"]
        self.payment <- map ["payment"]
        self.phone <- map ["phone"]
        self.gallery <- map ["gallery"] // arreglar
    }
        
}

   
    
    
    


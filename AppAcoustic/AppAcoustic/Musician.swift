//
//  Musician.swift
//  AppAcoustic
//
//  Created by Evelyn on 12/6/18.
//  Copyright © 2018 Evelyn. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import MapKit
import Firebase

class Musician: Mappable {
    
    var name: String?
    var image: String?
    var age: String?
    var city: String?
    var genre: String?
    var instrument: String?
    var email: String?
    var photo: [String]?
    
    required init?(map: Map) {
        
    }
    
    init(name: String?, image: String?, age: String, city: String, genre: String, instrument: String, email: String, photo: [String]){
        self.name = name
        self.image = image
        self.age = age
        self.city = city
        self.genre = genre
        self.instrument = instrument
        self.email = email
        self.photo = photo
    }

    func mapping(map: Map) {
        self.name <- map["name"]
        self.image <- map ["image"]
        self.age <- map ["age"]
        self.city <- map ["city"]
        self.genre <- map ["genre"]
        self.instrument <- map ["instrument"]
        self.email <- map ["email"]
        self.photo <- map ["photo"]
        
        if (self.photo == nil){
            self.photo = []
        }
    }
    
    func toJSON() -> [String:Any] {
    return [
            "name":self.name!,
            "image":self.image!,
            "age":self.age!,
            "city":self.city!,
            "genre":self.genre!,
            "instrument":self.instrument!,
            "email":self.email!,
            "photo":self.photo!,
        ]
    }
}

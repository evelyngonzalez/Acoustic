//
//  Gallery.swift
//  AppAcoustic
//
//  Created by Evelyn on 21/6/18.
//  Copyright © 2018 Evelyn. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import MapKit
import Firebase

class Gallery: Mappable {
    

    var image: String?

    
    required init?(map: Map) {
        
    }
    
    init( image: String?){
      
        self.image = image
    }
    
    func mapping(map: Map) {
        self.image <- map ["image"]
       
    }
}

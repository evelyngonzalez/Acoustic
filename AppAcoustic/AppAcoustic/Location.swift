



import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class Location: Mappable {
    
    required init?(map: Map) {
        
    }
    
    var lat: Double?
    var lon: Double?
    
    init(latX: Double, latY: Double){
        self.lat = latX
        self.lon = latY
    }
    
    func mapping(map: Map) {
        self.lat <- map["lat"]
        self.lon <- map ["lon"]
    }
    
}

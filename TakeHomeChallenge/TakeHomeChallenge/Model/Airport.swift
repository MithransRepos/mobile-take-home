//
//  Airport.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

struct Airport : Decodable{
    var iata:String
    var name:String
    var city:String
    var country:String
    var latitude:Double
    var longitude:Double
    enum CodingKeys: String, CodingKey {
        case iata = "IATA 3"
        case name = "Name"
        case city = "City"
        case country = "Country"
        case latitude = "Latitute"
        case longitude = "Longitude"
        
    }
}
extension Airport: Hashable {}

extension Airport: Equatable {
    
    static func == (lhs:Airport, rhs:Airport) -> Bool {
        return lhs.iata == rhs.iata && lhs.name == rhs.name
    }
    
}

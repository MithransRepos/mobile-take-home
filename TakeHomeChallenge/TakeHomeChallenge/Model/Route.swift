//
//  Route.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation
struct  Route: Decodable {
    var airlineId:String
    var origin:String
    var destination:String
    
    enum CodingKeys: String, CodingKey {
        case airlineId = "Airline Id"
        case origin = "Origin"
        case destination = "Destination"
    }
}

extension Route:Equatable{}

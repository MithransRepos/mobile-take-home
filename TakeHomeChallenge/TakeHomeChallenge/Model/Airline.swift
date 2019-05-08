//
//  Airline.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

struct  Airline: Decodable {
    var name:String
    var twoDigitCode:String
    var threeDigitCode:String
    var country:String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case twoDigitCode = "2 Digit Code"
        case threeDigitCode = "3 Digit Code"
        case country = "Country"
    }
}

extension Airline:Equatable{}

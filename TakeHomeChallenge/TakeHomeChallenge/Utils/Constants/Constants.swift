//
//  StringConstants.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

enum CSVFile {
    static let airports = "airports"
    static let airlines = "airlines"
    static let routes = "routes"
}
enum ErrorMessage {
    static let invalidOrigin = "Please enter a valid 3 digit IATA code for origin airport"
    static let invalidDestination = "Please enter a valid 3 digit IATA code for destination airport"
    static let sameOrigin = "Sorry origin & destination can't be same. Please change & try again"
    static let noRoute = "Sorry, We could not any planes between these two airports. Please change & try again"
}

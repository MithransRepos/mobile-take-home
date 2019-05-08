//
//  Edge.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

public struct Edge<T:Hashable> {
    public let source: Vertex<T>
    public let destination: Vertex<T>
    public let weight: Double?
    public let via: String?
}

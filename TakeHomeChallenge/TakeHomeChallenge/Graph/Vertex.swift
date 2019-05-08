//
//  Vertex.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

public struct Vertex<T:Hashable> {
    public let data: T
}

extension Vertex: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(data)
    }
    
    public static func ==(lhs: Vertex, rhs: Vertex)-> Bool {
        return lhs.data == rhs.data
    }
}

extension Vertex:CustomStringConvertible {
    public var description: String {
        return "\(String(describing: index)): \(data)"
    }
}

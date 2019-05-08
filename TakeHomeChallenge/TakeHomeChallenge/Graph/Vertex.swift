//
//  Vertex.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

class Vertex<Element: Equatable> {
    var value: Element
    private(set) var adjacentEdges: [DirectedEdge<Element>] = []
    
    init(_ value: Element) {
        self.value = value
    }
    
    func addEdge(_ edge: DirectedEdge<Element>) {
        self.adjacentEdges.append(edge)
    }
    
    func edgeForDestination(_ destination: Vertex<Element>) -> DirectedEdge<Element>? {
        return adjacentEdges.filter { $0.destination == destination }.first
    }
}

extension Vertex: Equatable {
    static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.value == rhs.value
    }
}

extension Vertex: CustomStringConvertible {
    var description: String {
        return "\n[Vertex]: \(value) | [Adjacent Edges]: [\(adjacentEdges)]"
    }
}

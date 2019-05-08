//
//  AdjancencyList.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.//

import Foundation

public class AdjacencyList<T:Hashable>: Graph {
    
    private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]
    public init() {}
    
    
    public func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(data: data)
        adjacencies[vertex] = []
        return vertex
    }
    
    public func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?, via:String?) {
        let edge = Edge(source: source, destination: destination, weight: weight,via: via)
        adjacencies[source]?.append(edge)
    }
    
    public func edges(from source: Vertex<T>) -> [Edge<T>] {
        return adjacencies[source] ?? []
    }
    
    public func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        return edges(from: source) .first {$0.destination == destination}?.weight
    }
    
}


extension AdjacencyList: CustomStringConvertible {
    
    public var description: String {
        var result = ""
        for (vertex, edges ) in adjacencies {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [\(edgeString)]\n")
        }
        return result
    }
}

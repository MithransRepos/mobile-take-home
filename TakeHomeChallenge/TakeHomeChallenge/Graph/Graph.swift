//
//  Graph.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation


public enum EdgeType {
    case directed
    case undirected
}

public protocol Graph {
    associatedtype Element:Hashable
    
    func createVertex(data:Element) -> Vertex<Element>
    func addDirectedEdge(from source:Vertex<Element>, to destination: Vertex<Element>, weight: Double?, via:String?)
    func addUndirectedEdge(between source: Vertex<Element>,
                           and destination: Vertex<Element>, weight: Double?, label:String?)
    
    func add(_ edge: EdgeType, from source: Vertex<Element>,
             to destination: Vertex<Element>, weight: Double?, label:String?)
    
    func edges(from source: Vertex<Element>)-> [Edge<Element>]
    func weight(from source: Vertex<Element>,
                to destination: Vertex<Element>)-> Double? 
}

extension Graph {
    
    public func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?, label: String?) {
        addDirectedEdge(from: source, to: destination, weight: weight, via:label )
        addDirectedEdge(from: destination, to: source, weight: weight, via:label)
    }
    
    public func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?, label:String?) {
        
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight, via:label)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight, label: label)
        }
    }
}

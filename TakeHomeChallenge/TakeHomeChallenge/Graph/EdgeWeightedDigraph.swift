//
//  EdgeWeightedDigraph.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

class EdgeWeightedDigraph<Element: Equatable> {
    private(set) var vertices: [Vertex<Element>] = []
    
    func addVertex(_ vertex: Vertex<Element>) {
        vertices.append(vertex)
    }
    
    func addVertexes(_ vertexes: [Vertex<Element>]) {
        vertices.append(contentsOf: vertexes)
    }
    
    private func addVertexIfNotPresent(vertex: Vertex<Element>) {
        guard vertices.contains(vertex) == false else {
            return
        }
        addVertex(vertex)
    }
    
    func addEdge(source: Vertex<Element>, destination: Vertex<Element>, weight: Double) {
        
        addVertexIfNotPresent(vertex: source)
        addVertexIfNotPresent(vertex: destination)
        
        // If we find an existing edge, just update the weight.
        if let existingEdge = source.edgeForDestination(destination) {
            existingEdge.weight = weight
        } else {
            let newEdge = DirectedEdge<Element>(source: source, destination: destination, weight: weight)
            source.addEdge(newEdge)
        }
    }
    
    func adjacentEdges(forVertex vertex: Vertex<Element>) -> [DirectedEdge<Element>] {
        return vertex.adjacentEdges
    }
    
    func edges() -> [DirectedEdge<Element>] {
        return vertices
            .reduce([DirectedEdge<Element>]()) {
                (result, vertex) -> [DirectedEdge<Element>] in
                return result + vertex.adjacentEdges
        }
    }
    
    func edgesCount() -> Int {
        return edges().count
    }
    
    func verticesCount() -> Int {
        return vertices.count
    }
}

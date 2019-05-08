//
//  GLRouteSearchViewModel.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation


class GLRouteSearchViewModel {

    var airlineMap: [String: Airline] = [:]
    var airportVertexMap: [String: Vertex<Airport>] = [:]
    var graph = EdgeWeightedDigraph<Airport>()
    var airportIATAArray: [String] = []
    
    init() {
            self.computeGraph()
    }
    
    
    func computeGraph() {
        self.airportVertexMap = CSVHelper.parseAirportCSV()
        self.airportIATAArray = Array(airportVertexMap.keys)
        self.graph.addVertexes(Array(airportVertexMap.values))
        self.airlineMap = CSVHelper.parseAirlineCSV()
        CSVHelper.parseRouteCSV(airportVertexMap: airportVertexMap, graph: &graph)
        
        guard let source = airportVertexMap["ABJ"] else { return }
        guard let destionation = airportVertexMap["BRU"] else { return }
        
        let dijkstra = DijkstraShortestPath(graph, source: source)
        
        print("Path to Dublin: ", dijkstra.distanceTo(destionation))
    }
}

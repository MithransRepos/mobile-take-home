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
    var graph = AdjacencyList<Airport>()
    var airportIATAArray: [String] = []
    
    init() {
        self.computeGraph()
    }
    
    
    func computeGraph() {
        self.airlineMap = CSVHelper.parseAirlineCSV()
        self.airportVertexMap = CSVHelper.parseAirportCSV(graph: &graph)
        CSVHelper.parseRouteCSV(airlineMap: airlineMap, airportVertexMap: airportVertexMap, graph: &graph)
        
//        guard let source = airportVertexMap["ABJ"] else { return }
//        guard let destionation = airportVertexMap["BRU"] else { return }
//        
//        let dijkstra = Dijsktra(graph: graph)
//        let pathFromSource = dijkstra.shortestPath(from: source)
//        print("Path: ", dijkstra.shortestPath(to: destionation, paths: pathFromSource))
    }
}

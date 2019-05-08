//
//  GLRouteSearchViewModel.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

protocol GLRouteSearchViewModelDelegate {
    func showErrorMessage(message: String)
    func searchSuccess(route: [Edge<Airport>])
}

class GLRouteSearchViewModel {
    
    private var graph = AdjacencyList<Airport>()
    private var airlineMap: [String: Airline] = [:]
    private var airportVertexMap: [String: Vertex<Airport>] = [:]
    private var airportIATAArray: [String] = []
    private var dijkstraGraph: Dijsktra<Airport>?
    var delegate: GLRouteSearchViewModelDelegate?
    
    
    init() {
        self.computeGraph()
    }
    
    
    private func computeGraph() {
        self.airlineMap = CSVHelper.parseAirlineCSV()
        self.airportVertexMap = CSVHelper.parseAirportCSV(graph: &graph)
        self.airportIATAArray = Array(airportVertexMap.keys)
        CSVHelper.parseRouteCSV(airlineMap: airlineMap, airportVertexMap: airportVertexMap, graph: &graph)
    }
    
    private func getDijsktraGraph() -> Dijsktra<Airport>{
        guard let dijkstraGraph = self.dijkstraGraph else {
            let dijkstraGraph = Dijsktra(graph: graph)
            self.dijkstraGraph = dijkstraGraph
            return dijkstraGraph
        }
        return dijkstraGraph
    }
    
    private func searchRoute(originVertex: Vertex<Airport>, destinationVertex: Vertex<Airport>) -> [Edge<Airport>]{
        let dijkstraGraph = self.getDijsktraGraph()
        let pathFromOrigin = dijkstraGraph.shortestPath(from: originVertex)
        return dijkstraGraph.shortestPath(to: destinationVertex, paths: pathFromOrigin)
    }
    
    
    
}
extension GLRouteSearchViewModel{
    
    func search(origin: String?, destination: String?){
        
        guard let origin = origin  else {
            self.delegate?.showErrorMessage(message: ErrorMessage.invalidOrigin)
            return
        }
        
        guard let destination = destination  else {
            self.delegate?.showErrorMessage(message: ErrorMessage.invalidOrigin)
            return
        }
        
        if !isValidInput(origin: origin, destination: destination) { return }
        
        guard let originVertex = airportVertexMap[origin] else {
            self.delegate?.showErrorMessage(message: ErrorMessage.invalidOrigin)
            return
        }
        
        guard let destionationVertex = airportVertexMap[destination] else {
            self.delegate?.showErrorMessage(message: ErrorMessage.invalidDestination)
            return
        }
        
        let route = self.searchRoute(originVertex: originVertex, destinationVertex: destionationVertex)
        
        if route.count == 0 {
            self.delegate?.showErrorMessage(message: ErrorMessage.noRoute)
        }else{
            self.delegate?.searchSuccess(route: route)
        }
    }
    
    func isValidInput(origin: String, destination: String) -> Bool{
        
        if origin.count != 3 {
            self.delegate?.showErrorMessage(message: ErrorMessage.invalidOrigin)
            return false
        }else if destination.count != 3{
            self.delegate?.showErrorMessage(message: ErrorMessage.invalidDestination)
            return false
        }else if origin == destination{
            self.delegate?.showErrorMessage(message: ErrorMessage.sameOrigin)
            return false
        }
        
        return true
    }
}

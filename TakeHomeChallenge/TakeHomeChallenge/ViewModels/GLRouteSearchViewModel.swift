//
//  GLRouteSearchViewModel.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation
import CoreLocation

/*
 Protocol oriented programming
*/
protocol GLRouteSearchViewModelDelegate {
    func showErrorMessage(message: String)
    func searchSuccess(route: RouteInfo)
}
// type alias for tuples
typealias RouteInfo = (aiports: [Airport], coordinates: [CLLocationCoordinate2D], path: String)

class GLRouteSearchViewModel {
    
    private var graph = AdjacencyList<Airport>()
    private var airlineMap: [String: Airline] = [:]
    private var airportVertexMap: [String: Vertex<Airport>] = [:]
    private var dijkstraGraph: Dijsktra<Airport>?
    
    /*
     viewModel delegate
    */
    var delegate: GLRouteSearchViewModelDelegate?
    
    
    init() {
        self.computeGraph()
    }
    
    /*
     CSV to graph
    */
    private func computeGraph() {
        self.airlineMap = CSVHelper.parseAirlineCSV()
        self.airportVertexMap = CSVHelper.parseAirportCSV(graph: &graph)
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
    
    
    private func getAirportsFromRoute(route: [Edge<Airport>]){
        var airports: [Airport] = []
        var points: [CLLocationCoordinate2D] = []
        var airlines: [String] = []
        var pathText: String = ""
        for path in route{
            let sourceAirport = path.source.data
            let destinationAirport = path.destination.data
            addAirportDetails(airport: sourceAirport, airports: &airports, points: &points)
            addAirportDetails(airport: destinationAirport, airports: &airports, points: &points)
            airlines.append(path.via ?? "")
            pathText += "\(path.source.data.iata) -> \(path.destination.data.iata) via: \(path.via ?? "")\n"
        }
        self.delegate?.searchSuccess(route: (airports, points, pathText))
    }
    
    private func addAirportDetails(airport: Airport, airports: inout [Airport], points: inout [CLLocationCoordinate2D]){
        if airports.contains(airport) { return }
        airports.append(airport)
        points.append(CLLocationCoordinate2DMake(airport.latitude, airport.longitude))
    }
}

/*
  ViewModel functions are grouped in this extension
*/
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
            self.getAirportsFromRoute(route: route)
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

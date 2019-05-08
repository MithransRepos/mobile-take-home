//
//  CSVHelper.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation
import CSV

class CSVHelper {
    
    static func getCSVReader(filename:String) -> CSVReader? {
        guard let filepath = Bundle.main.path(forResource: filename, ofType: "csv") else { return nil }
        guard let stream = InputStream(fileAtPath: filepath) else { return nil }
        guard let reader = try? CSVReader(stream: stream, hasHeaderRow: true) else { return nil }
        return reader
    }
    
    static func parseAirlineCSV() -> [String: Airline]{
        var data: [String: Airline] = [:]
        guard let csvReader = getCSVReader(filename: CSVFile.airlines) else { return data }
        do {
            let decoder = CSVRowDecoder()
            while csvReader.next() != nil {
                let row = try decoder.decode(Airline.self, from: csvReader)
                data[row.twoDigitCode] = row
            }
        } catch {
            // Invalid row format
        }
        return data
    }
    
    static func parseAirportCSV(graph: inout AdjacencyList<Airport>) -> [String: Vertex<Airport>]{
        var vertexMap: [String: Vertex<Airport>] = [:]
        guard let csvReader = getCSVReader(filename: CSVFile.airports) else { return vertexMap }
        do {
            let decoder = CSVRowDecoder()
            while csvReader.next() != nil {
                let row = try decoder.decode(Airport.self, from: csvReader)
                let vertex = graph.createVertex(data: row)
                vertexMap[row.iata] = vertex
            }
        } catch {
            // Invalid row format
        }
        return vertexMap
    }
    
    
    static func parseRouteCSV(airlineMap: [String: Airline], airportVertexMap: [String: Vertex<Airport>], graph: inout AdjacencyList<Airport>) -> Void{
        guard let csvReader = getCSVReader(filename: CSVFile.routes) else { return }
        do {
            let decoder = CSVRowDecoder()
            while csvReader.next() != nil {
                let row = try decoder.decode(Route.self, from: csvReader)
                let airlineName = airlineMap[row.airlineId]?.name
                if let originVertex = airportVertexMap[row.origin], let destinationVertex = airportVertexMap[row.destination]{
                        graph.addDirectedEdge(from: originVertex, to: destinationVertex, weight: 1, via: airlineName)
                }
            }
        } catch {
            // Invalid row format
        }
    }
    
    
    
    
}

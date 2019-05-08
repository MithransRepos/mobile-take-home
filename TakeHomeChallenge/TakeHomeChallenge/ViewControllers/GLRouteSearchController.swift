//
//  GLRouteSearchController.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit
import MapKit

class GLRouteSearchController: UIViewController {
    
    @IBOutlet weak var sourceAirportSearchbar: UISearchBar!
    @IBOutlet weak var destinationAirportSearchbar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var routeLabel: UILabel!
    let viewModel = GLRouteSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupNavigationItems()
        self.setupDelegate()
        self.hideKeyboardOnTouchOutside()
        self.showMapRoute(visiblity: false)
    }
    
    private func setupDelegate(){
        self.sourceAirportSearchbar.delegate = self
        self.destinationAirportSearchbar.delegate = self
        self.viewModel.delegate = self
        self.mapView.delegate = self
    }
    
    private func showMapRoute(visiblity: Bool){
        self.mapView.isHidden = !visiblity
        self.routeLabel.isHidden = !visiblity
    }
    
    
}

extension GLRouteSearchController{
    
    private func setupNavigationItems(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style:UIBarButtonItem.Style.plain, target: self, action: #selector(search))
    }
    
    @objc func search(){
        self.viewModel.search(origin: self.sourceAirportSearchbar.text, destination: self.destinationAirportSearchbar.text)
    }
}

extension GLRouteSearchController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar == sourceAirportSearchbar{
            destinationAirportSearchbar.becomeFirstResponder()
        }else{
            searchBar.resignFirstResponder()
            search()
        }
    }
}

extension GLRouteSearchController: GLRouteSearchViewModelDelegate{
    
    func showErrorMessage(message: String) {
        self.showMapRoute(visiblity: false)
        self.showAlert(alertTitle: nil, alertMessage: message)
    }
    
    func searchSuccess(route: (aiports: [Airport], coordinates: [CLLocationCoordinate2D], path: String)) {
        self.dismissKeyboard()
        self.mapView.removeAnnotations(mapView.annotations)
        self.mapView.removeOverlays(mapView.overlays)
        self.drawRouteInMap(route: route)
        self.routeLabel.text = route.path
        self.showMapRoute(visiblity: true)
    }
    
}

extension GLRouteSearchController{
    
    private func drawRouteInMap(route: RouteInfo){
        for airport in route.aiports{
            let mapPin2 = MapPin(pinTitle: airport.name, pinSubTitle: airport.iata, location: CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude))
            self.mapView.addAnnotation(mapPin2)
        }
        let polygon = MKPolygon(coordinates: route.coordinates, count: route.coordinates.count)
        self.mapView.addOverlay(polygon)
        let span = MKCoordinateSpan(latitudeDelta: 150, longitudeDelta: 150)
        let region = MKCoordinateRegion(center: route.coordinates[0], span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
}

extension GLRouteSearchController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.lightGray
        renderer.lineWidth = 4.0
        return renderer
    }
    
}
extension String
{
    func stringByReplacingFirstOccurrenceOfString(
        target: String, withString replaceString: String) -> String
    {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }
}

//
//  GLRouteSearchController.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit

class GLRouteSearchController: UIViewController {
    
    @IBOutlet weak var sourceAirportSearchbar: UISearchBar!
    @IBOutlet weak var destinationAirportSearchbar: UISearchBar!
    
    let viewModel = GLRouteSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupNavigationItems()
        self.setupDelegate()
        
    }
    
    private func setupDelegate(){
        self.sourceAirportSearchbar.delegate = self
        self.destinationAirportSearchbar.delegate = self
        self.viewModel.delegate = self
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
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let totalCharacters = (searchBar.text?.appending(text).count ?? 0) - range.length
        return totalCharacters <= 3
    }
}

extension GLRouteSearchController: GLRouteSearchViewModelDelegate{
    
    func showErrorMessage(message: String) {
        self.showAlert(alertTitle: nil, alertMessage: message)
    }
    
    func searchSuccess(route: [Edge<Airport>]) {
        
    }
    
    
}

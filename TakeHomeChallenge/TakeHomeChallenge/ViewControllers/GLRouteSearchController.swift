//
//  GLRouteSearchController.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit

class GLRouteSearchController: UIViewController {
    
    let viewModel = GLRouteSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupNavigationItems()
        
    }


}

extension GLRouteSearchController{
    private func setupNavigationItems(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style:UIBarButtonItem.Style.plain, target: self, action: #selector(search))
    }
    
    @objc func search(){
       
    }
    
    
}


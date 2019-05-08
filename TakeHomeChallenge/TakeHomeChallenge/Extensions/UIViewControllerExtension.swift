//
//  UIViewControllerExtension.swift
//  TakeHomeChallenge
//
//  Created by Mithran Natarajan on 5/8/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showAlert(alertTitle title: String?, alertMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (_) in }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func hideKeyboardOnTouchOutside(){
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapToDismiss.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapToDismiss)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
}

//
//  Alert.swift
//  Map
//
//  Created by Дмитрий Скок on 27.12.2022.
//

import UIKit

extension UIViewController {
    
    func alertAddAddress(title: String, placeholder: String, completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default) { (action) in
            let textFieldText = alertController.textFields?.first
            guard let text = textFieldText?.text else { return }
            completion(text)
        }
        
        alertController.addTextField() { (textField) in
            textField.placeholder = placeholder
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func alertError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(alertOK)
        present(alertController, animated: true)
    }
}

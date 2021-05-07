//
//  UIViewControllerExtension.swift
//  MovieSearch
//
//  Created by David Boyd on 5/7/21.
//

import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        
        let alertController = UIAlertController(title: "Error", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
        
    }
}

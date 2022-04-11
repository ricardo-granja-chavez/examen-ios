//
//  AlertController.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import UIKit

class AlertController {
    
    static var shared = AlertController()
    
    func show(controller: UIViewController, title: String, message: String, completion: @escaping () -> Void = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.popoverPresentationController?.sourceView = controller.view
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (_) in
            completion()
        }))
        controller.present(alert, animated: true)
    }
    
    func showSheet(controller: UIViewController, title: String, message: String, actions: [UIAlertAction], completion: @escaping () -> Void = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = controller.view
        for action in actions { alert.addAction(action) }
        controller.present(alert, animated: true, completion: completion)
    }
    
}

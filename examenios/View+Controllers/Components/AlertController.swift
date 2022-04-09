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
    
//    func showDone(controller: UIViewController, message: String, completion: @escaping CompletionHandler = {}) {
//        let alert = UIAlertController(title: "Exito", message: message, preferredStyle: .alert)
//        alert.popoverPresentationController?.sourceView = controller.view
//        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (_) in
//            completion()
//        }))
//        controller.present(alert, animated: true)
//    }
//
//    func showError(controller: UIViewController, message: String, completion: @escaping CompletionHandler = {}) {
//        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        alert.popoverPresentationController?.sourceView = controller.view
//        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (_) in
//            completion()
//        }))
//        controller.present(alert, animated: true)
//    }
    
    func showQuestion(controller: UIViewController, title: String, message: String, yes: @escaping () -> Void = {}, no: @escaping () -> Void = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.popoverPresentationController?.sourceView = controller.view
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
            no()
        }))
        alert.addAction(UIAlertAction(title: "Sí", style: .destructive, handler: { (_) in
            yes()
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

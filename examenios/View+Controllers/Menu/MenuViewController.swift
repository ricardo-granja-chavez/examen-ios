//
//  MenuViewController.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuTableView: MenuTableView!
    
    private var selfieImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Examen iOS"
        
        menuTableView.register(UINib(nibName: TextFieldCell.identifier, bundle: nil), forCellReuseIdentifier: TextFieldCell.identifier)
        menuTableView.dataSource = menuTableView
        menuTableView.delegate = menuTableView
        menuTableView.onPress = { (type) in
            switch type {
            case .selfie:
                self.showMultimediaOptions()
            case .graphics:
                break
            default:
                break
            }
        }
    }
    
    @objc private func showMultimediaOptions() {
        let multimediaController = MultimediaImagePickerController()
        
        multimediaController.delegate = multimediaController
        multimediaController.getEditedImage = { (image) in
            self.selfieImage = image
        }
        multimediaController.allowsEditing = true
        multimediaController.mediaTypes = ["public.image"]
        
        var actions: [UIAlertAction] = []
        
        if let _ = self.selfieImage {
            actions.append(UIAlertAction(title: "Visualizar",
                                         style: .default,
                                         handler: { (_) in
                let vc = ZoomImageViewController(image: self.selfieImage)
                self.navigationController?.pushViewController(vc, animated: true)
            }))
            actions.append(UIAlertAction(title: "Retomar la foto",
                                         style: .default,
                                         handler: { (_) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    multimediaController.sourceType = .camera
                    self.present(multimediaController, animated: true)
                } else {
                    AlertController.shared.show(controller: self, title: "Aviso", message: "Actualmente no se puede acceder a la cámara.\nInténtelo más tarde.")
                }
            }))
        } else {
            actions.append(UIAlertAction(title: "Tomar la foto",
                                         style: .default,
                                         handler: { (_) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    multimediaController.sourceType = .camera
                    self.present(multimediaController, animated: true)
                } else {
                    AlertController.shared.show(controller: self, title: "Aviso", message: "Actualmente no se puede acceder a la cámara.\nInténtelo más tarde.")
                }
            }))
        }
        
        actions.append(UIAlertAction(title: "Cancelar",
                                     style: .cancel))
        
        AlertController.shared.showSheet(controller: self,
                                         title: "Opciones",
                                         message: "Seleccione una opción",
                                         actions: actions)
    }
    
}

//
//  MenuViewController.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import UIKit
import SVProgressHUD

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuTableView: MenuTableView!
    
    private var nameText: String = ""
    private var selfieImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Examen iOS"
        
        menuTableView.register(UINib(nibName: TextFieldCell.identifier, bundle: nil), forCellReuseIdentifier: TextFieldCell.identifier)
        menuTableView.dataSource = menuTableView
        menuTableView.delegate = menuTableView
        menuTableView.tableFooterView = UIView()
        menuTableView.onPress = { (type) in
            switch type {
            case .selfie:
                self.showMultimediaOptions()
            case .graphics:
                let vc = GraphicsViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        }
        menuTableView.getText = { (text) in
            self.nameText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        observeColor()
        
        if let appColor = Constants.shared.appColor {
            self.view.backgroundColor = UIColor(hexString: appColor)
        }
    }
    
    @objc private func showMultimediaOptions() {
        let multimediaController = MultimediaImagePickerController()
        
        multimediaController.delegate = multimediaController
        multimediaController.getOriginalImage = { (image) in
            self.selfieImage = image
        }
        //multimediaController.allowsEditing = true
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
                    multimediaController.cameraDevice = .front
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
                    multimediaController.cameraDevice = .front
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

    private func sendInformation() {
        SVProgressHUD.show()
        UserService().createUser(name: self.nameText, selfie: self.selfieImage) { (result) in
            SVProgressHUD.dismiss()
            
            switch result {
            case .success(let content):
                if content {
                    AlertController.shared.show(controller: self, title: "Exito", message: "La información ha sido agregada exitosamente.")
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    @IBAction func sendInformationAction(_ sender: Any) {
        if !self.nameText.isEmpty && self.selfieImage != nil {
            self.sendInformation()
        } else {
            AlertController.shared.show(controller: self, title: "Aviso", message: "Se debe de agregar un nombre del usuario y una selfie.")
        }
    }
    
    private func observeColor() {
        ColorService().observeColor { (result) in
            switch result {
            case.success(_):
                DispatchQueue.main.async {
                    if let appColor = Constants.shared.appColor {
                        self.view.backgroundColor = UIColor(hexString: appColor)
                    }
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }

}

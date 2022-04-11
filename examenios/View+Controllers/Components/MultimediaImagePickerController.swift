//
//  MultimediaImagePickerController.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import Foundation

import UIKit

class MultimediaImagePickerController: UIImagePickerController {
    var getOriginalImage: (UIImage) -> Void = { (_) in }
}

extension MultimediaImagePickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            getOriginalImage(image)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

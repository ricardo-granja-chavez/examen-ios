//
//  ColorService.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 10/04/22.
//

import UIKit
import FirebaseDatabase

class ColorService {
    private var ref: DatabaseReference { Database.database().reference() }
    
    func observeColor(completion: @escaping (Result<UIColor, APIError>) -> Void) {
        ref.child("color_app").observe(.childChanged) { (snapshot) in
            if let color = snapshot.value as? String {
                var colorString = color
                
                if colorString.hasPrefix("#") {
                    colorString.remove(at: colorString.startIndex)
                }
                
                if colorString.count < 6 {
                    let numberOfMissingCharacters = 6 - colorString.count
                    
                    for _ in 0...numberOfMissingCharacters - 1 {
                        colorString.append("0")
                    }
                }
                
                Constants.shared.appColor = colorString
                
                if let appColor = Constants.shared.appColor {
                    completion(.success(UIColor(hexString: appColor.uppercased())))
                } else {
                    completion(.failure(.apiDefinedError(error: "Parse error")))
                }
            } else {
                completion(.failure(.apiDefinedError(error: "Parse error")))
            }
        } withCancel: { (error) in
            completion(.failure(.apiDefinedError(error: "Firebase error: \(error)")))
        }

    }
}

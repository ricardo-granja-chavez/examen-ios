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
                Constants.shared.appColor = color.uppercased()
                
                if let appColor = Constants.shared.appColor {
                    completion(.success(UIColor(hexString: appColor)))
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

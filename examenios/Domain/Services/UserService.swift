//
//  UserService.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 10/04/22.
//

import Foundation
import Firebase

class UserService {
    private let db = Firestore.firestore()
    
    func createUser(name: String, selfie: UIImage, completion: @escaping (Result<Bool, APIError>) -> Void) {
        let documentReferences = self.db.collection("user").document(name)
        let data: [String : Any] = ["name": name,
                                    "selfie": selfie.jpegData(compressionQuality: 0.1) ?? Data()]
        
        documentReferences.setData(data) { (error) in
            if let error = error {
                completion(.failure(.responseErrorMessage(message: error.localizedDescription)))
            } else {
                completion(.success(true))
            }
        }
    }
}

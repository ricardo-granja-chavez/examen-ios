//
//  Constants.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 10/04/22.
//

import UIKit

class Constants {
    static let shared = Constants()
    
    var appColor: String? {
        get {
            if let savedObject = UserDefaults.standard.object(forKey: "app_color") as? Data {
                return try? JSONDecoder().decode(String.self, from: savedObject)
            } else {
                return nil
            }
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "app_color")
            }
        }
    }
}

//
//  QuestionRouter.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import Foundation

enum QuestionRouter: APIConfiguration {
    case getQuestions
    
    var path: String {
        switch self {
        case .getQuestions:
            return "/helloWorld"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getQuestions:
            return .GET
        }
    }
    
    var parameters: Data? {
        switch self {
        case .getQuestions:
            return nil
        }
    }
    
    func toRequest() -> URLRequest {
        let url = URL(string: APIManager.shared.baseURL + path)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = parameters
        request.allHTTPHeaderFields = APIManager.shared.headers
        return request
    }
}

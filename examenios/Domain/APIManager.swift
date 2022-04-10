//
//  APIManager.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import Foundation

class APIManager {
    
    public static var shared = APIManager()
    
    public let baseURL: String = "https://us-central1-bibliotecadecontenido.cloudfunctions.net"
    
    public let headers: [String : String] = ["Content-Type": "application/json",
                                             "Accept": "application/json"]
    
    public func request<T: Codable>(url: URLRequest, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let urlR = url.url else { return }
        let urlSession = URLSession(configuration: .default)
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                
                debugPrint("URL: [\(statusCode)] \(urlR.description)")
                if let data = data {
                    let dataString = String(data: data, encoding: .utf8) ?? "No data"
                    debugPrint("DATA: \(dataString)")
                }
                
                switch statusCode {
                case 100...199:
                    completion(.failure(.serverError(error: "code 100...199")))
                case 200...299:
                    guard let data = data, data.count > 0 else {
                        if let emptyJson = "{}".data(using: .utf8), let decodedObject = try? JSONDecoder().decode(T.self, from: emptyJson) {
                            completion(.success(decodedObject))
                        }
                        return
                    }
                    do {
                        let decodedObject = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedObject))
                    } catch {
                        completion(.failure(.jsonDecodingError))
                    }
                case 300...399:
                    completion(.failure(.serverError(error: "code 300...399")))
                case 400...499:
                    if let data = data {
                        let dataString = String(data: data, encoding: .utf8) ?? "No data"
                        completion(.failure(.apiDefinedError(error: dataString)))
                    } else {
                        completion(.failure(.badRequest))
                    }
                case 500...599:
                    completion(.failure(.serverError(error: "code 500...599")))
                default:
                    completion(.failure(.serverError(error: "server")))
                }
                
            } else if let httpError = error {
                completion(.failure(.apiDefinedError(error: httpError.localizedDescription)))
            }
        }.resume()
    }
}

public protocol APIConfiguration {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Data? { get }
    
    func toRequest() -> URLRequest
}

public enum APIError: Error {
    case jsonDecodingError
    case serverError(error: String)
    case badRequestData(data: Data)
    case badRequest
    case responseErrorMessage(message: String)
    case notInternetConection
    case multipartEncodingError
    case apiDefinedError(error: String)
}

public enum HTTPMethod: String {
    case GET
    case PUT
    case POST
    case DELETE
}

//
//  NetworkManager.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 05.12.2024.
//

import Foundation

// MARK: - Network Errors
enum NetworkError: String, Error {
    case networkError = "Network error"
    case responseError = "Response Error"
    case serverError = "Server error"
    case dataError = "Data error"
    case parseError = "Parsing error"
    
    static func get(_ err: NetworkError) -> String {
        switch err {
        case .networkError: return "Network error description"
        case .responseError: return "Response error description"
        case .serverError: return "Server error description"
        case .dataError: return "Data error description"
        case .parseError: return "Parsing error description"
        }
    }
}

// MARK: - Network Output Protocol
protocol NetworkOutput: AnyObject {
    func doRequest(endpoint: CountryEndpoint, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

// MARK: - Network Manager
final class NetworkManager: NetworkOutput {
    static let shared = NetworkManager()
    
    private init() {}
    
    func doRequest(endpoint: CountryEndpoint, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let url = endpoint.url
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("Request URL: \(request.url?.absoluteString ?? "")")
        print("Request Method: \(request.httpMethod ?? "")")
        print("Request Headers: \(request.allHTTPHeaderFields ?? [:])")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("Response Status Code: \(httpResponse.statusCode)")
                print("Response Headers: \(httpResponse.allHeaderFields)")
            }
            
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.responseError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}

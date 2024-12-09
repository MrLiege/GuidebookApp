//
//  CountryAPI.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 05.12.2024.
//

import Foundation

final class CountryAPI {
    private let networkManager: NetworkOutput
    
    init(NetworkManager: NetworkOutput = NetworkManager.shared) {
        self.networkManager = NetworkManager
    }

    func fetchCountries(completion: @escaping (Result<[Country], NetworkError>) -> Void) {
        networkManager.doRequest(endpoint: .getAllCountries) { result in
            switch result {
            case .success(let data):                
                do {
                    let serverCountries = try JSONDecoder().decode([ServerCountry].self, from: data)
                    let countries = serverCountries.map { Country(serverEntity: $0) }
                    completion(.success(countries))
                } catch {
                    completion(.failure(.parseError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

//
//  ElectedViewModel.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 06.12.2024.
//

import Foundation
import Combine

final class ElectedViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var countries: [Country] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchSavedCountries()
        
        $searchText
            .sink { [weak self] searchText in
                self?.filterCountries(with: searchText)
            }
            .store(in: &cancellables)
    }
    
    func fetchSavedCountries() {
        countries = DataController.shared.fetchCountries()
    }
    
    private func filterCountries(with searchText: String) {
        if searchText.isEmpty {
            fetchSavedCountries()
        } else {
            countries = countries.filter { $0.name.common.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func isFavorite(country: Country) -> Bool {
        
        return countries.contains(where: { $0.id == country.id })
    }
    
    func toggleFavorite(country: Country) {
        if isFavorite(country: country) {
            DataController.shared.deleteCountry(country)
        } else {
            DataController.shared.saveCountry(country)
        }
        fetchSavedCountries()
    }
    
    func updateFavorites() {
        fetchSavedCountries()
    }
}

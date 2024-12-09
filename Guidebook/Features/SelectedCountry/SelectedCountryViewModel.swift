//
//  SelectedCountryViewModel.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 06.12.2024.
//

import Foundation
import Combine

final class SelectedCountryViewModel: ObservableObject {
    @Published var isFavorite: Bool = false
    var country: Country
    private var cancellables = Set<AnyCancellable>()
    
    init(country: Country, isInitiallyFavorite: Bool) {
        self.country = country
        self.isFavorite = isInitiallyFavorite
        
        bind()
    }
}

extension SelectedCountryViewModel {
    func bind() {
        $isFavorite
            .dropFirst()
            .sink { [weak self] isFavorite in
                print("Изменение isFavorite: \(isFavorite)")
                self?.handleFavoriteChange(isFavorite: isFavorite)
            }
            .store(in: &cancellables)
    }
    
    private func handleFavoriteChange(isFavorite: Bool) {
        if isFavorite {
            print("Сохранение страны: \(country.name.common)")
            DataController.shared.saveCountry(country)
        } else {
            print("Удаление страны: \(country.name.common)")
            DataController.shared.deleteCountry(country)
        }
    }
}

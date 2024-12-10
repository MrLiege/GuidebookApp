//
//  MainViewModel.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 05.12.2024.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    let input: Input
    @Published var output: Output
    
    private let countryAPI = CountryAPI()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.input = Input()
        self.output = Output()
        
        bind()
    }
    
    func bind() {
        countriesBind()
        searchBind()
    }
    
    // MARK: - Get Countries
    func countriesBind() {
        input.onAppear
            .sink { [weak self] in
                self?.fetchCountries()
            }
            .store(in: &cancellables)
    }
    
    private func fetchCountries() {
        fetchCountriesWithRetry(retryCount: 3)
    }
    
    private func fetchCountriesWithRetry(retryCount: Int) {
        countryAPI.fetchCountries { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let countries):
                    if !countries.isEmpty {
                        self?.output.model = countries
                        print("\(countries)")
                    } else if retryCount > 0 {
                        self?.fetchCountriesWithRetry(retryCount: retryCount - 1)
                    } else {
                        self?.output.errorMessage = "No countries found after retries."
                        self?.output.showErrorAlert = true
                    }
                case .failure(let error):
                    if retryCount > 0 {
                        self?.fetchCountriesWithRetry(retryCount: retryCount - 1)
                    } else {
                        self?.output.errorMessage = "Failed to fetch countries: \(error.rawValue)"
                        self?.output.showErrorAlert = true
                    }
                }
            }
        }
    }

    
    // MARK: - Search Country
    func searchBind() {
        $output
            .map(\.searchText)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.filterCountry(by: text)
            }
            .store(in: &cancellables)
    }
    
    private func filterCountry(by text: String) {
        if text.count >= 2 {
            output.model = output.model.filter { $0.name.common.lowercased().contains(text.lowercased()) }
        } else {
            fetchCountries()
        }
    }
    
    // MARK: - Favorite Country
    func isFavorite(country: Country) -> Bool {
        return DataController.shared.fetchCountries().contains(where: { $0.id == country.id })
    }
    
    func toggleFavorite(country: Country) {
        if isFavorite(country: country) {
            DataController.shared.deleteCountry(country)
        } else {
            DataController.shared.saveCountry(country)
        }
        fetchSavedCountries()
    }
    
    private func fetchSavedCountries() {
        output.model = DataController.shared.fetchCountries()
    }
}

extension MainViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var model: [Country] = [.empty]
        var errorMessage: String?
        var searchText: String = ""
        var showErrorAlert = false
    }
}

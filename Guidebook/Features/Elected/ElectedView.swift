//
//  ElectedView.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 06.12.2024.
//

import SwiftUI

struct ElectedView: View {
    @StateObject var viewModel = ElectedViewModel()
    @FocusState private var isFocus: Bool
    @State private var navPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            ScrollView {
                SearchBar(searchText: $viewModel.searchText, isFocus: $isFocus)
                    .padding(5)
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.countries) { country in
                        CountryCell(
                            country: country,
                            isFavorite: viewModel.isFavorite(country: country),
                            onToggleFavorite: viewModel.toggleFavorite
                        )
                        .padding(5)
                        .onTapGesture {
                            navPath.append(country)
                        }
                    }
                }
            }
            .navigationDestination(for: Country.self) { country in
                SelectedCountryView(country: country, isInitiallyFavorite: viewModel.isFavorite(country: country))
                    .onDisappear {
                        viewModel.updateFavorites()
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient.dimSkyGradient().ignoresSafeArea())
            .onAppear {
                viewModel.fetchSavedCountries()
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

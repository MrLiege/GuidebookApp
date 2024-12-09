//
//  CountryTableView.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 06.12.2024.
//

import SwiftUI

struct CountryTableView: View {
    @ObservedObject var viewModel: MainViewModel
    @Binding var navPath: NavigationPath
    @FocusState private var isFocus: Bool
    
    var body: some View {
        ScrollView {
            SearchBar(searchText: $viewModel.output.searchText, isFocus: $isFocus)
                .padding(5)
            LazyVStack(spacing: 0) {
                ForEach(viewModel.output.model) { country in
                    CountryCell(country: country)
                        .padding(5)
                        .onTapGesture {
                            navPath.append(country)
                        }
                }
            }
        }
        .navigationDestination(for: Country.self, destination: { country in
            SelectedCountryView(country: country, isInitiallyFavorite: false)
        })
        .onAppear(perform: viewModel.input.onAppear.send)
        .ignoresSafeArea(.keyboard)
    }
}

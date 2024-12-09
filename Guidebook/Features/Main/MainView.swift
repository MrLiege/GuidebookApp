//
//  MainView.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 05.12.2024.
//

import SwiftUI

struct MainView: View {
    @State private var navPath = NavigationPath()
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        bodyView()
    }
}

private extension MainView {
    @ViewBuilder
    func bodyView() -> some View {
        NavigationStack(path: $navPath) {
            VStack {
                CountryTableView(viewModel: viewModel, navPath: $navPath)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient.darkSkyGradient().ignoresSafeArea())
        }
    }
}

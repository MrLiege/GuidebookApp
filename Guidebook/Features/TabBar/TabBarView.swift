//
//  TabBarView.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 06.12.2024.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var viewModel = TabBarViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.tabBars.currentTab) {
            mainTabView
            electedTabView
        }
        .tint(Color.black)
    }
}

private extension TabBarView {
    @ViewBuilder
    var mainTabView: some View {
        let tab = TabBarViewModel.Tab.main
        MainView(viewModel: MainViewModel())
            .tabItem {
                Image(systemName: tab.iconName)
                Text(tab.titleName)
            }
            .tag(tab)
    }
    
    @ViewBuilder
    var electedTabView: some View {
        let tab = TabBarViewModel.Tab.elected
        ElectedView(viewModel: ElectedViewModel())
            .tabItem {
                Image(systemName: tab.iconName)
                Text(tab.titleName)
            }
            .tag(tab)
    }
}

#Preview {
    TabBarView()
}

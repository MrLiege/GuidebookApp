//
//  TabBarViewModel.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 06.12.2024.
//

import Foundation

final class TabBarViewModel: ObservableObject {
    @Published var tabBars: TabBars
    
    init() {
        self.tabBars = TabBars()
    }
}

extension TabBarViewModel {
    enum Tab: String {
        case main
        case elected
        
        var iconName: String {
            switch self {
            case .main:
                return "globe.desk.fill"
            case .elected:
                return "star.fill"
            }
        }
        
        var titleName: String {
            switch self {
            case .main:
                return "Countries"
            case .elected:
                return "Elected"
            }
        }
    }
}


extension TabBarViewModel {
    struct TabBars {
        var currentTab: Tab = .main
        var mainViewModel = MainViewModel()
        var electedViewModel = ElectedViewModel()
    }
}

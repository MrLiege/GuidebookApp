//
//  SearchBar.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 06.12.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @FocusState.Binding var isFocus: Bool
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                TextField("Find country", text: $searchText)
                    .foregroundStyle(.black)
                    .focused($isFocus)
                Spacer()
            }
            .padding()
            .background(.white)
            .cornerRadius(10)
        }
    }
}


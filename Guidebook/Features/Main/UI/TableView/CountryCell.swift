//
//  CountryCell.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 06.12.2024.
//

import SwiftUI

struct CountryCell: View {
    var country: Country
    var isFavorite: Bool?
    var onToggleFavorite: ((Country) -> Void)?
    
    var body: some View {
        VStack {
            CountryCellView()
        }
    }
}

private extension CountryCell {
    @ViewBuilder
    func CountryCellView() -> some View {
        HStack {
            nameAndRegion()
            Text("\(country.flag)")
        }
        .background(Color.teal.opacity(0.3))
        .cornerRadius(20)
        .shadow(color: Color.cyan, radius: 0.1)
    }
    
    @ViewBuilder
    func nameAndRegion() -> some View {
        VStack {
            HStack {
                Text("\(country.region)")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                    .padding(8)
                    .background(Color.yellow)
                    .cornerRadius(.infinity)
                Spacer()
            }
            HStack {
                Text("\(country.name.common)")
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                Spacer()
            }
        }
        .padding()
        .background(Color.mint.opacity(0.4))
        .cornerRadius(20)
    }
}

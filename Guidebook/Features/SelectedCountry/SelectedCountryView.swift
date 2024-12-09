//
//  SelectedCountryView.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 06.12.2024.
//

import SwiftUI

struct SelectedCountryView: View {
    @StateObject private var viewModel: SelectedCountryViewModel
    @State private var showingShareSheet = false
    @State private var cachedImage: UIImage? = nil
    
    init(country: Country, isInitiallyFavorite: Bool) {
        _viewModel = StateObject(wrappedValue: SelectedCountryViewModel(country: country, isInitiallyFavorite: isInitiallyFavorite))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                flagImageView
                    .frame(height: 150)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.cyan.opacity(0.2).shadow(color: .black, radius: 0.5))
                    .cornerRadius(20)
                    .padding()
                
                infoCountryView
                    .frame(width: .infinity)
                    .padding()
                
                CountryMapView(latlng: viewModel.country.latlng)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient.skyGradient().ignoresSafeArea())
        .navigationTitle(viewModel.country.name.common)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button(action: {
                        viewModel.isFavorite.toggle()
                    }) {
                        Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                            .foregroundColor(viewModel.isFavorite ? .yellow : .gray)
                    }
                    Button(action: {
                        showingShareSheet = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(activityItems: [shareText()])
        }
    }
}

private extension SelectedCountryView {
    var flagImageView: some View {
        AsyncImage(url: URL(string: viewModel.country.flags.png)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
            case .failure:
                Image(systemName: "xmark.octagon.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.red)
                Text("Failed to load image")
            @unknown default:
                EmptyView()
            }
        }
    }
    
    private var infoCountryView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack() {
                Text("Официальное название: ")
                    .fontWeight(.bold)
                Spacer()
                Text(viewModel.country.name.official)
            }
            
            HStack {
                Text("Столица: ")
                    .fontWeight(.bold)
                Spacer()
                Text(viewModel.country.capital.joined(separator: ", "))
            }
            
            HStack {
                Text("Население: ")
                    .fontWeight(.bold)
                Spacer()
                Text("\(viewModel.country.population)")
            }
            
            HStack {
                Text("Площадь: ")
                    .fontWeight(.bold)
                Spacer()
                Text("\(viewModel.country.area, specifier: "%.0f") km²")
            }
            
            HStack {
                Text("Валюта: ")
                    .fontWeight(.bold)
                Spacer()
                Text(viewModel.country.currencies.map { "\($1.name) (\($1.symbol))" }.joined(separator: ", "))
            }
            
            HStack {
                Text("Языки: ")
                    .fontWeight(.bold)
                Spacer()
                Text(viewModel.country.languages.values.joined(separator: ", "))
            }
            
            HStack {
                Text("Часовые пояса: ")
                    .fontWeight(.bold)
                Spacer()
                Text(viewModel.country.timezones.joined(separator: ", "))
            }
            
            HStack {
                Text("Координаты: ")
                    .fontWeight(.bold)
                Spacer()
                Text(viewModel.country.latlng.map { "\($0)" }.joined(separator: ", "))
            }
        }
        .padding()
        .background(Color.cyan.opacity(0.2).shadow(color: .black, radius: 0.5))
        .cornerRadius(20)
    }
    
    private func shareText() -> String {
        return """
        Официальное название: \(viewModel.country.name.official)
        Столица: \(viewModel.country.capital.joined(separator: ", "))
        Население: \(viewModel.country.population)
        Площадь: \(viewModel.country.area) km²
        Валюта: \(viewModel.country.currencies.map { "\($1.name) (\($1.symbol))" }.joined(separator: ", "))
        Языки: \(viewModel.country.languages.values.joined(separator: ", "))
        Часовые пояса: \(viewModel.country.timezones.joined(separator: ", "))
        Координаты: \(viewModel.country.latlng.map { "\($0)" }.joined(separator: ", "))
        """
    }
}



struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


//#Preview {
//    SelectedCountryView(country: Country(name: Name(from: ServerName(common: "США", official: "Соединенные Штаты Америки")), flag: "🇬🇸", region: "Americas", capital: ["St. George's"], population: 112519, area: 344.0, currencies: ["CHF" : Currency(from: ServerCurrency(name: "Swiss franc", symbol: "Fr."))], languages: ["fra": "French", "gsw": "Swiss German", "ita": "Italian", "roh": "Romansh"], timezones: ["UTC-02:00"], latlng: [-54.28, -36.5], flags: Flags(from: ServerFlags(png: "https://flagcdn.com/w320/gd.png", svg: "https://flagcdn.com/gd.svg"))))
//}

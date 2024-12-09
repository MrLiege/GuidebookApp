//
//  CountryMapView.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 09.12.2024.
//

import SwiftUI
import MapKit
import UIKit

struct CountryMapView: View {
    var latlng: [Double]
    
    @State private var region: MKCoordinateRegion
    
    init(latlng: [Double]) {
        self.latlng = latlng
        let coordinate = CLLocationCoordinate2D(latitude: latlng[0], longitude: latlng[1])
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        ))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [CountryAnnotation(coordinate: region.center)]) { annotation in
            MapPin(coordinate: annotation.coordinate, tint: .red)
        }
        .frame(height: 300)
        .cornerRadius(20)
        .padding()
    }
}

struct CountryAnnotation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

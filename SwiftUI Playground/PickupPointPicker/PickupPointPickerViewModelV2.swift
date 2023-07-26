//
//  PickupPointPickerViewModelV2.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 23/06/2023.
//

import MapKit

final class PickupPointPickerViewModelV2: ObservableObject {
    @Published var keywords: String = ""
    @Published var selected: PickupPoint? = nil
    @Published var points: Loadable<[PickupPoint], Error> = .loaded([])
    @Published var isSheetPresented: Bool = false
    
    /// A  rectangular geographic region that centers the map.
    ///
    /// The default value is the Vestiaire Collective office in France.
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.876192, longitude: 2.333455),
        latitudinalMeters: 3000,
        longitudinalMeters: 3000
    )
}

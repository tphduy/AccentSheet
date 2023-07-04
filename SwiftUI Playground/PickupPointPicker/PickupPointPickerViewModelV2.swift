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
    @Published var map: PickupPointMapViewModel = PickupPointMapViewModel()
}

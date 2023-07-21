//
//  PickupPointPickerV2.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 23/06/2023.
//

import SwiftUI

struct PickupPointPickerV2: View {
    @StateObject var viewModel = PickupPointPickerViewModelV2()

    var body: some View {
        PickupPointMap(viewModel: viewModel.map)
            .ignoresSafeArea(edges: [.bottom, .horizontal, .leading, .trailing])
            .navigationTitle("Pickup Point Picker")
            .toolbar {
                ToolbarItem {
                    Toggle("Toggle Bottom Sheet", isOn: $viewModel.isSheetPresented)
                }
            }
            .bottomSheet(isPresented: $viewModel.isSheetPresented) {
                Text("Carrier List")
                    .font(.title)
                    .padding()
                    .bottomSheetPresentationDetents([.natural, .large])
                    .bottomSheetPresentationDragIndicator(.visible)
            }
    }
}

struct PickupPointPickerV2_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PickupPointPickerV2()
        }
    }
}

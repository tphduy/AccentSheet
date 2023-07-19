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
            .ignoresSafeArea()
            .navigationTitle("Pickup Point Picker")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Toggle("Toggle Bottom Sheet", isOn: $viewModel.isSheetPresented)
                }
            }
            .accentSheet(isPresented: $viewModel.isSheetPresented) {
                VStack {
                    Text("Header")
                        .font(.title)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum")
                }
                .padding()
                .accentPresentationDetents([.height(100), .large])
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

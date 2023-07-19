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
                List {
                    Section {
                        ForEach(0...100, id: \.self) { (number: Int) in
                            Text("\(number)")
                        }
                    } header: {
                        Button("Confirm") {
                            viewModel.isSheetPresented = false
                        }
//                        Text("Select a carrier")
//                            .frame(maxWidth: .infinity)
//                            .font(.title)
//                            .background(Color.red.opacity(0.5))
                    }
                }
                .listStyle(.plain)
                .accentPresentationDetents([.height(100), .medium, .large])
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

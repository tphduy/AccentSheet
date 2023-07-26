//
//  PickupPointPickerV2.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 23/06/2023.
//

import SwiftUI
import MapKit

struct PickupPointPickerV2: View {
    @StateObject var viewModel = PickupPointPickerViewModelV2()

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                TextField("Foo", text: $viewModel.keywords)
                    .padding()
                Map(coordinateRegion: $viewModel.region)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea(edges: .all.subtracting(.top))
            }
            .bottomSheet(isPresented: .constant(true)) {
                list
            }
            confirmButton
        }
        .navigationTitle("Pickup Point Picker")
    }

    var list: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    Section {
                        ForEach(0...100, id: \.self) { number in
                            Text(String(number))
                        }
                    }
                }
            }
        }
//        .bottomSheetPresentationDetents([.height(150), .medium, .large])
//        .bottomSheetPresentationPassthroughBackgroundDisabled()
    }

    var confirmButton: some View {
        Button("Confirm", action: {})
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.white)
            .background(Color.black.ignoresSafeArea(edges: [.bottom, .horizontal]))
    }
}

struct PickupPointPickerV2_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PickupPointPickerV2()
        }
    }
}

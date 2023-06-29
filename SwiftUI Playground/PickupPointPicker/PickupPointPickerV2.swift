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
            .accentSheet(isPresented: $viewModel.isSheetPresented) {
                Text("Header")
            } content: {
                Text("Content")
            }
    }
}

struct PickupPointPickerV2_Preview: PreviewProvider {
    static var previews: some View {
        PickupPointPickerV2()
    }
}

//
//  PickupPointMap.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 23/06/2023.
//

import SwiftUI
import MapKit

struct PickupPointMap: View {
    @ObservedObject var viewModel: PickupPointMapViewModel = PickupPointMapViewModel()

    var body: some View {
        Map(coordinateRegion: $viewModel.region)
    }
}

struct PickupPointMap_Previews: PreviewProvider {
    static var previews: some View {
        PickupPointMap()
    }
}

//
//  LicenseAgreement.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 20/07/2023.
//

import SwiftUI

struct LicenseAgreement: View {
    var onAgree: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 16) {
            Text("License Agreement")
                .font(.title)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
            Button("Agree", action: onAgree)
        }
    }
}

struct LicenseAgreement_Previews: PreviewProvider {
    static var previews: some View {
        LicenseAgreement()
    }
}

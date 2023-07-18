//
//  ParallaxHeader.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 11/07/2023.
//

import SwiftUI

struct ParallaxHeader<Content: View, Space: Hashable>: View {
    let content: () -> Content
    let coordinateSpace: Space
    let defaultHeight: CGFloat

    init(
        coordinateSpace: Space,
        defaultHeight: CGFloat,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        self.content = content
        self.coordinateSpace = coordinateSpace
        self.defaultHeight = defaultHeight
    }

    var body: some View {
        GeometryReader { proxy in
            content()
                .frame(
                    width: proxy.size.width,
                    height: proxy.size.height + heightModifier(for: proxy)
                )
                .offset(y: offset(for: proxy))
        }.frame(height: defaultHeight)
    }

    private func offset(for proxy: GeometryProxy) -> CGFloat {
        -proxy
            .frame(in: .named(coordinateSpace))
            .minY
    }

    private func heightModifier(for proxy: GeometryProxy) -> CGFloat {
        let frame = proxy.frame(in: .named(coordinateSpace))
        return max(0, frame.minY)
    }
}

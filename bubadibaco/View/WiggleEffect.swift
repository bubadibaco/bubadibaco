//
//  WiggleEffect.swift
//  bubadibaco
//
//  Created by Evelyn Callista Yaurentius on 23/07/24.
//

import Foundation
import SwiftUI

import SwiftUI

struct OffsetEffect: ViewModifier {
    @State private var isAnimating = false

    func body(content: Content) -> some View {
        content
            .offset(x: isAnimating ? 0 : -1.5, y: 0)
//            .frame(width: isExpanded ? 200 : 100, height: 100)
            .animation(Animation.easeInOut(duration: 0.1).repeatForever(autoreverses: true))
            .onAppear {
                self.isAnimating = true
            }
    }
}

extension View {
    func offsetWiggle() -> some View {
        self.modifier(OffsetEffect())
    }
}

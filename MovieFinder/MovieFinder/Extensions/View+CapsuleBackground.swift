//
//  View+CapsuleBackground.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 30/10/2024.
//

import SwiftUI

struct CapsuleBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
//            .background(.backgroundGray)
            .background(.backgroundGrayBis)
            .clipShape(Capsule())
    }
}

extension View {
    func capsuleBackground() -> some View {
        self.modifier(CapsuleBackground())
    }
}

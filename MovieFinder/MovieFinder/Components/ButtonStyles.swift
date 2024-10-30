//
//  ButtonStyles.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 27/10/2024.
//

import SwiftUI

struct GradientBorderButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .padding(.horizontal, 64)
            .background(
                RoundedRectangle(cornerRadius: .infinity)
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [.borderGreen, .borderPurple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 3
                    )
                    .shadow(color: .borderGreen.opacity(0.8), radius: 10, x: -5, y: -5)
                    .shadow(color: .borderPurple.opacity(0.8), radius: 10, x: 5, y: 5)
                    .background(
                        RoundedRectangle(cornerRadius: .infinity)
                            .fill(Color.clear)
                            .shadow(color: .borderGreen.opacity(0.8), radius: 10, x: -5, y: -5)
                            .shadow(color: .borderPurple.opacity(0.8), radius: 10, x: 5, y: 5)
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

@available(iOS 17, *)
#Preview("Icon buttons", traits: .sizeThatFitsLayout) {
    VStack {
        Button("Enter now") {
            
        }
        .buttonStyle(GradientBorderButtonStyle())
    }
    .padding()
}

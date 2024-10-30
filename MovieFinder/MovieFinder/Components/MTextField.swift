//
//  MTextField.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 27/10/2024.
//

import SwiftUI

struct MTextField: View {
    
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder).foregroundColor(.gray)
        )
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [.borderGreen, .borderPurple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 3
                    )
                    .shadow(
                        color: .borderGreen.opacity(0.8),
                        radius: 10,
                        x: -5,
                        y: -5
                    )
                    .shadow(
                        color: .borderPurple.opacity(0.8),
                        radius: 10,
                        x: 5,
                        y: 5
                    )
                    .background(
                        RoundedRectangle(cornerRadius: .infinity)
                            .fill(Color.clear)
                            .shadow(
                                color: .borderGreen.opacity(0.8),
                                radius: 10,
                                x: -5,
                                y: -5
                            )
                            .shadow(
                                color: .borderPurple.opacity(0.8),
                                radius: 10,
                                x: 5,
                                y: 5
                            )
                    )
            )
            .autocorrectionDisabled()
    }
}

#Preview {
    MTextField(
        placeholder: "Placeholder",
        text: .constant("")
    )
}

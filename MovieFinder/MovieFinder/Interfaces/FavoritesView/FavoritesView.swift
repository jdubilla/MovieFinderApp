//
//  FavoritesView.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 03/11/2024.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject private var itemsManager = FavoritesMediaManager.shared
    
    var body: some View {
        if itemsManager.items.isEmpty {
            Text("Aucun favoris")
                .font(.title)
                .foregroundColor(.gray)
        } else {
            ForEach(itemsManager.items, id: \.id) { item in
                Text(item.mediaType)
            }
        }
    }
}

#Preview {
    FavoritesView()
}

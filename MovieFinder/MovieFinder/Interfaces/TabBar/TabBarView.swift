//
//  TabBarView.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 03/11/2024.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label(
                        "Recherche",
                        systemImage: "magnifyingglass"
                    )
                }
            
            FavoritesView()
                .tabItem {
                    Label(
                        "Favoris",
                        systemImage: "star"
                    )
                }
        }
        .tint(.white)
    }
}

#Preview {
    TabBarView()
}

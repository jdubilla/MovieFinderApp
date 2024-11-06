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
                        "tab_search",
                        systemImage: "magnifyingglass"
                    )
                }
            
            FavoritesView()
                .tabItem {
                    Label(
                        "tab_favorites",
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

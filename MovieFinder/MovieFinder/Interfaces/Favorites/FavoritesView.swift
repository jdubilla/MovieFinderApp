//
//  FavoritesView.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 03/11/2024.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject private var vm = FavoritesViewModel()
    @StateObject private var itemsManager = FavoritesMediaManager.shared
    
    var body: some View {
        VStack(spacing: 0) {
            if itemsManager.items.isEmpty {
                Text("Aucun favoris")
                    .font(.title)
                    .foregroundColor(.gray)
            } else if vm.isLoading {
                ProgressView()
            } else {
                NavigationStack {
                    VStack(spacing: 0) {
                        ScrollView {
                            if !vm.favSeries.isEmpty {
                                Text("Séries")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding(.top)
                                    .foregroundStyle(.borderGray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ForEach(vm.favSeries, id: \.id) { serie in
                                    NavigationLink(destination: MediaDetailView(media: serie)) {
                                        MediaListElementView(media: serie)
                                    }
                                }
                            }
                            
                            if !vm.favMovies.isEmpty {
                                Text("Films")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding(.top)
                                    .foregroundStyle(.borderGray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ForEach(vm.favMovies, id: \.id) { movie in
                                    NavigationLink(destination: MediaDetailView(media: movie)) {
                                        MediaListElementView(media: movie)
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal)
                    .background(.backgroundGray)
                    .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            vm.fetchData(items: itemsManager.items)
        }
    }
}

#Preview {
    FavoritesView()
}

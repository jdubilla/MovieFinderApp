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
                    ScrollView {
                        VStack(spacing: 0) {
                            if !vm.favSeries.isEmpty {
                                Text("Séries")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding(.top)
                                    .foregroundStyle(.borderGray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom)
                                
                                ForEach(vm.favSeries, id: \.id) { serie in
                                    NavigationLink(destination: MediaDetailView(media: serie)) {
                                        MediaListElementView(media: serie)
                                            .padding(.top, 8)
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
                                    .padding(.vertical)
                                
                                ForEach(vm.favMovies, id: \.id) { movie in
                                    NavigationLink(destination: MediaDetailView(media: movie)) {
                                        MediaListElementView(media: movie)
                                            .padding(.top, 8)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
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

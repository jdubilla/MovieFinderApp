//
//  FavoritesViewModel.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 04/11/2024.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    
    @Published var favSeries: [MediaDetailResponseModel] = []
    @Published var favMovies: [MediaDetailResponseModel] = []
    @Published var isLoading = false
    
    func fetchData(items: [FavoriteMedia]) {
        guard !items.isEmpty else { return }
        
        isLoading = true
        
        let series = items.filter { $0.mediaType == .tv }
        let movies = items.filter { $0.mediaType == .movie }
        
        var responseSeries: [MediaDetailResponseModel] = []
        var responseMovies: [MediaDetailResponseModel] = []
        
        Task { @MainActor in
            defer { isLoading = false }
            for serie in series {
                let response = try await TmdbManager.shared.getMediaById(mediaType: .tv, id: serie.id)
                responseSeries.append(response)
            }
            
            for movie in movies {
                let response = try await TmdbManager.shared.getMediaById(mediaType: .movie, id: movie.id)
                responseMovies.append(response)
            }
            
            favSeries = responseSeries
            favMovies = responseMovies
        }
    }
}

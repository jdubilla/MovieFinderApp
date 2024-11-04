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
                var response = try await TmdbManager.shared.getMediaById(mediaType: .tv, id: serie.id)
                response.mediaType = .tv
                responseSeries.append(response)
            }
            
            for movie in movies {
                var response = try await TmdbManager.shared.getMediaById(mediaType: .movie, id: movie.id)
                response.mediaType = .movie
                responseMovies.append(response)
            }
            
            favSeries = responseSeries
            favMovies = responseMovies
        }
    }
}

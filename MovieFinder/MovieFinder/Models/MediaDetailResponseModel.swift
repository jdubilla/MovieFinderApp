//
//  MediaDetailResponseModel.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 31/10/2024.
//

import Foundation

// MARK: - MediaDetailResponseModel
struct MediaDetailResponseModel: Codable {
    let backdropPath: String
    let firstAirDate, releaseDate: String?
    let genres: [Genre]
    let homepage: String
    let id: Int
    let numberOfEpisodes, numberOfSeasons: Int?
    let originalName, originalTitle: String?
    let overview: String
    let posterPath: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case releaseDate = "release_date"
        case genres, homepage, id
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var date: String? {
        return releaseDate ?? firstAirDate ?? nil
    }
    
    var nameOrTitle: String {
        return originalName ?? originalTitle ?? ""
    }
}

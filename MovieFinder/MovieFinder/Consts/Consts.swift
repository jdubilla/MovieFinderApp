//
//  Consts.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 02/11/2024.
//

import Foundation

enum Const {
    enum Url {
        static let baseUrl = "https://api.themoviedb.org/3"
        static let imageBaseUrl = "https://image.tmdb.org/t/p/original"
        
        static let homeImages = "\(baseUrl)/trending/all/day"
        static let suggestions = "\(baseUrl)/search/multi"
        static let movieGenres = "\(baseUrl)/genre/movie/list"
        static let tvGenres = "\(baseUrl)/genre/tv/list"
        static let mediaByIdTv = "\(baseUrl)/tv/"
        static let mediaByIdMovie = "\(baseUrl)/movie/"
        static let mediaTvGenre = "\(baseUrl)/genre/tv/list"
        
        static func mediaById(mediaType: MediaType, id: Int) -> String {
            switch mediaType {
            case .tv:
                return "\(baseUrl)/tv/\(id)"
            default:
                return "\(baseUrl)/movie/\(id)"
            }
        }
        
        static func mediaCredits(mediaType: MediaType, id: Int) -> String {
            switch mediaType {
            case .tv:
                return "\(baseUrl)/tv/\(id)/credits"
            default:
                return "\(baseUrl)/movie/\(id)/credits"
            }
        }
        
        static func mediaRecommendations(mediaType: MediaType, id: Int) -> String {
            switch mediaType {
            case .tv:
                return "\(baseUrl)/tv/\(id)/recommendations"
            default:
                return "\(baseUrl)/movie/\(id)/recommendations"
            }
        }
    }
}

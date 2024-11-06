//
//  HomeImageResponseModel.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 26/10/2024.
//

import Foundation

// MARK: - HomeImageResponseModel
struct HomeImageResponseModel: Codable {
    let results: [MediaDetailResponseModel]
}

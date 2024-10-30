//
//  Bundle.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 29/10/2024.
//

import Foundation

extension Bundle {
    var apiKey: String {
        return infoDictionary?["API_KEY"] as? String ?? ""
    }
}

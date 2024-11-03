//
//  String+Date.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 30/10/2024.
//

import Foundation

extension String {
    func getYear() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return String(year)
        }
        return nil
    }
}

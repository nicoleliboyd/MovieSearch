//
//  Movie.swift
//  MovieSearch
//
//  Created by David Boyd on 5/7/21.
//

import UIKit

struct Movie: Decodable {
    
    let results: [Result]
    
    struct Result: Decodable {
        let original_title: String
        let overview: String
        let poster_path: String?
        let vote_average: Double
    }
}

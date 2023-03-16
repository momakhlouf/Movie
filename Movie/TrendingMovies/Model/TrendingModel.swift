//
//  MovieModel.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 06/03/2023.
//

import Foundation

struct TrendingModel: Codable , Hashable{
    
    let page: Int
    let results: [TrendingMovie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    
}

// MARK: - trendingMovie
struct TrendingMovie: Codable , Equatable , Hashable {
    let backdropPath: String?
    let id: Int?
    let name: String?
    let originalName: String?
    let overview, posterPath: String
    let firstAirDate: String?
    let voteAverage: Double?
    let title, releaseDate: String?
    
    var posterURL : String? {
       "https://image.tmdb.org/t/p/w400\(posterPath)"
    }
   

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, name
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case title
        case releaseDate = "release_date"
      
    }
}



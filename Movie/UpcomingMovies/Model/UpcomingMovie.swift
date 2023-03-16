//
//  UpcomingModel.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 13/03/2023.
//

import Foundation

struct UpcomingModel: Codable , Hashable{
   
    let page: Int
    let results: [UpcomingMovie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
  
        case  page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
//    func hash(into hasher: inout Hasher) {
//          hasher.combine(results)
//      }
//
//    static func == (lhs: UpcomingModel, rhs: UpcomingModel) -> Bool {
//        return lhs.results == rhs.results
//    }
}


// MARK: - upcomingMovie
struct UpcomingMovie: Codable , Hashable{
    let backdropPath: String?
    let id: Int?
    let originalTitle, overview: String?
    let posterPath, releaseDate, title: String
    let voteAverage: Double?
    
        var posterURL : String? {
           "https://image.tmdb.org/t/p/w400\(posterPath)"
        }
   

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
       
    }
    
//    func hash(into hasher: inout Hasher) {
//           hasher.combine(id)
//       }
//       
//       // Implement the Equatable protocol by providing an == operator.
//       static func == (lhs: UpcomingMovie, rhs: UpcomingMovie) -> Bool {
//           return lhs.id == rhs.id
//       }
}



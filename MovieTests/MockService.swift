//
//  MockService.swift
//  MovieTests
//
//  Created by Mohamed Makhlouf Ahmed on 15/03/2023.
//

import Foundation
@testable import Movie
import Combine

class MockService: ServiceProtocol {
    let trendingMovies : [TrendingMovie] = [
        TrendingMovie(backdropPath: "", id: 1, name: "one", originalName: "one", overview: "one", posterPath: "one", firstAirDate: "one", voteAverage: 1, title: "one", releaseDate: "one"),
        TrendingMovie(backdropPath: "", id: 1, name: "one", originalName: "one", overview: "two", posterPath: "two", firstAirDate: "two", voteAverage: 1, title: "two", releaseDate: "two")
    ]
    
    let upcomingMovies : [UpcomingMovie] = [
        UpcomingMovie(backdropPath: "one", id: 1, originalTitle: "one", overview: "one", posterPath: "one", releaseDate: "one", title: "one", voteAverage: 1),
        UpcomingMovie(backdropPath: "two", id: 1, originalTitle: "two", overview: "two", posterPath: "two", releaseDate: "two", title: "two", voteAverage: 1)
    ]
    func getTrendingMovies(page: Int) -> AnyPublisher<[TrendingMovie], Error> {
        Just(trendingMovies)
            .tryMap({$0})
            .eraseToAnyPublisher()
    }
    
    func getUpcomingMovies() -> AnyPublisher<[UpcomingMovie], Error> {
        Just(upcomingMovies)
            .tryMap({$0})
            .eraseToAnyPublisher()
    }
    
}

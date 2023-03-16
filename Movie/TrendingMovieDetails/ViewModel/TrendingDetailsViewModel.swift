//
//  TrendingDetailsViewModel.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 08/03/2023.
//

import Foundation

class TrendingDetailsViewModel{
    
    
   var movie : TrendingMovie
    var movieImage : String
    var movieTitle : String
    var movieOverView : String
    var movieID : Int
    
    init(movie: TrendingMovie) {
        self.movie = movie
        
        self.movieID = movie.id ?? 1
        self.movieTitle = movie.title ?? movie.name ?? ""
        self.movieImage = movie.posterPath
        self.movieOverView = movie.overview
        
        
    }
}

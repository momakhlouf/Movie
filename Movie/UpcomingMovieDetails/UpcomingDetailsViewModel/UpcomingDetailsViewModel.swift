//
//  UpcomingDetailsViewModel.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 20/03/2023.
//

import Foundation

class UpcomingDetailsViewModel {

    var movie : UpcomingMovie
     var movieImage : String
     var movieTitle : String
     var movieOverView : String
     var movieID : Int
     
     init(movie: UpcomingMovie) {
         self.movie = movie
         self.movieID = movie.id ?? 1
         self.movieTitle = movie.title
         self.movieImage = movie.posterURL ?? ""
         self.movieOverView = movie.overview ?? ""
     }
}



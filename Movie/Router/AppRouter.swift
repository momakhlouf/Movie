//
//  AppRouter.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 08/03/2023.
//

import UIKit

class AppRouter {
    
    static var service : ServiceProtocol {
        return Service()
    }
    
    static func createTrendingMovieScene() -> UIViewController{
        let vc = MovieViewController(service: service)
        vc.title = "Trending"
        vc.tabBarItem = UITabBarItem(title: "Trending", image: UIImage(systemName: "flame.fill"), tag: 0)
        
        return vc
    }
    
    static func createUpcomingMovieScene() -> UIViewController{
        let vc = UpcomingMoviesViewController(service: service)
        vc.title = "Upcoming"
        vc.tabBarItem = UITabBarItem(title: "Upcoming", image: UIImage(systemName: "popcorn.fill"), tag: 1)
        
        return vc
    }
    
    static func createFavoriteMovieScene() -> UIViewController{
        let viewModel =  FavoriteMoviesViewModel()
        let vc =  FavoriteViewController(viewModel: viewModel)
        vc.title = "Favorite"
        vc.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart.fill"), tag: 1)
        
        return vc
    }
    
    
    
    static func createTrendingDetails(movie : TrendingMovie) -> UIViewController{
        let viewModel = TrendingDetailsViewModel(movie: movie)
        return TrendingMoviesDetailsViewController(viewModel: viewModel)
    }
    
    static func createUpcomingDetails(movie : UpcomingMovie)-> UIViewController{
        let viewModel = UpcomingDetailsViewModel(movie: movie)
        return UpcomingDetailsViewController(viewModel: viewModel)

    }
    
    
    
    //MARK: TABBAR
    static func createTabBarController()-> UITabBarController {
        
        let tabBarController = UITabBarController()
        
        let trendingViewController = createTrendingMovieScene()
        let trendingNavigationController = UINavigationController(rootViewController: trendingViewController)


        let upcomingViewController = createUpcomingMovieScene()
        let upcomingNavigationController = UINavigationController(rootViewController: upcomingViewController)
        
        let favoriteViewController = createFavoriteMovieScene()
        let favoriteNavigationController = UINavigationController(rootViewController: favoriteViewController)

        tabBarController.viewControllers = [trendingNavigationController,upcomingNavigationController,favoriteNavigationController]
        return tabBarController
    }
    
}



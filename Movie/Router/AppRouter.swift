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
        vc.tabBarItem = UITabBarItem(title: "Upcoming", image: UIImage(systemName: "heart.fill"), tag: 1)

        return vc
    }
    
    static func createTrendingDetails(movie : TrendingMovie) -> UIViewController{
        let viewModel = TrendingDetailsViewModel(movie: movie)
        return TrendingMoviesDetailsViewController(viewModel: viewModel)
    }
    
    static func createTabBarController()-> UITabBarController {
        
        let tabBarController = UITabBarController()
        
        let trendingViewController = createTrendingMovieScene()
        let trendingNavigationController = UINavigationController(rootViewController: trendingViewController)


        let upcomingViewController = createUpcomingMovieScene()
        let upcomingNavigationController = UINavigationController(rootViewController: upcomingViewController)

        tabBarController.viewControllers = [trendingNavigationController,upcomingNavigationController]
        return tabBarController
    }
    
 
    
    
    
    
}



//    func start(){
//
//        let trendingVC = MovieViewController(service: network)
//        let nav = UINavigationController(rootViewController: trendingVC)
//        nav.tabBarItem = UITabBarItem(title: "Now Playing", image: UIImage(systemName: "film"), tag: 0)
//
//        let upcomingVC =  UpcomingMoviesViewController(service: network)
//        let nav1 = UINavigationController(rootViewController: upcomingVC)
//        nav1.tabBarItem = UITabBarItem(title: "Now Playing", image: UIImage(systemName: "film"), tag: 1)
//
//
//        let tabbar = UITabBarController()
//        tabbar.viewControllers = [trendingVC , upcomingVC]
//
//        window.rootViewController = tabbar
//    }
//
    
    
   
    
    // let upcoming  = UpcomingMoviesViewController(viewModel: )
    


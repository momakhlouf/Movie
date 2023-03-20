//
//  NetworkClient.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 06/03/2023.
//

import Foundation
import Combine

protocol ServiceProtocol {
    func getTrendingMovies(page : Int)-> AnyPublisher<TrendingModel,Error>
    func getUpcomingMovies(page : Int)-> AnyPublisher<UpcomingModel,Error>
}

class Service : ServiceProtocol{
    
    var constant = ServiceConstant.shared
    
    
    //MARK: GET TRENDING MOVIES
    func getTrendingMovies(page : Int)-> AnyPublisher<TrendingModel, Error>{
        let urlString =  constant.serverAddress + constant.trending + constant.apiKey  + "&page=" + "\(page)"
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
           return URLSession.shared.dataTaskPublisher(for: url)
               .subscribe(on: DispatchQueue.global())
                .map{$0.data}
                .decode(type: TrendingModel.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
    }

    //MARK: GET UPCOMING MOVIES
    func getUpcomingMovies(page : Int) -> AnyPublisher<UpcomingModel , Error> {
        let urlString = constant.serverAddress + constant.upcoming + constant.apiKey + "&page=" + "\(page)"
        print(urlString)
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .map{$0.data}
            .decode(type: UpcomingModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error {
    case invalidURL
}



//
//  UpcomingMoviesViewModel.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 13/03/2023.
//

import Foundation
import Combine

class UpcomingMoviesViewModel {
    
    private let network : ServiceProtocol
    let errorPublisher = PassthroughSubject<Error, Never>()

    
    @Published var upcomingMovies : [UpcomingMovie] = []
    @Published var isLoading : Bool = false

    
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1

    
    init(network: ServiceProtocol) {
        self.network = network
        getUpcomingMovies()
    }
    
    //MARK: DATA FOR CELL
    func moviesContent()-> [UpcomingMovie]{
        return upcomingMovies
    }
    

    func getUpcomingMovies(){
        network.getUpcomingMovies(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished : break
                case .failure(let error):
                    self?.errorPublisher.send(error)
                }
            } receiveValue: { returnedMovies in
                self.upcomingMovies = returnedMovies
            }
            .store(in: &cancellables)

    }
    
    
    
}

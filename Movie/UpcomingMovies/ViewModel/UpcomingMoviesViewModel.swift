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
    @Published var isSearching: Bool = false

    let favoriteViewModel = FavoriteMoviesViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    private var totalPages : Int = 1


    func viewDidLoad(){
        getUpcomingMovies()
        loadMoreData()
    }
    
    init(network: ServiceProtocol) {
        self.network = network
    }
    
    //MARK: DATA FOR CELL
    func moviesContent()-> [UpcomingMovie]{
        return upcomingMovies
    }
    

    func getUpcomingMovies(){
      //  isLoading = true
        guard currentPage <= totalPages else {
            return }
        network.getUpcomingMovies(page: currentPage)
            .map{$0.results}
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished : break
                case .failure(let error):
                    self?.errorPublisher.send(error)
                }
            } receiveValue: { [weak self] returnedMovies in
                self?.upcomingMovies.append(contentsOf: returnedMovies)
                self?.currentPage += 1
            }
            .store(in: &cancellables)

    }
    
    func loadMoreData(){
        network.getUpcomingMovies(page: currentPage)
            .map({$0.totalPages})
            .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.errorPublisher.send(error)
                    }
                } receiveValue: { [weak self] totalPages in
                    self?.totalPages = totalPages
                }
                .store(in: &cancellables)
    }
    
    
    //MARK: ADD TO FAVORITES
    func addToFavorites(indexPath : IndexPath){
        let movie = moviesContent()[indexPath.row]

        favoriteViewModel.addFavorite(date: movie.releaseDate , id: Int64(movie.id ?? 0), overView: movie.overview ?? "", photo: movie.posterURL ?? "", rate: movie.voteAverage ?? 0, title: movie.title )
        print("pressed")
    }
}

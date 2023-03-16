//
//  TrendingViewModel.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 06/03/2023.
//

import Foundation
import Combine

class TrendingViewModel  {
 
    private let service : ServiceProtocol
    let errorPublisher = PassthroughSubject<Error, Never>()

    @Published  var movies : [TrendingMovie] = []
    @Published  var searchedMovie : [TrendingMovie] = []
    @Published var isLoading : Bool = false
    @Published var isSearching : Bool = false

    private var currentPage: Int = 1
    private var totalPages : Int = 1

    private var cancellables = Set<AnyCancellable>()
   
    init(service : ServiceProtocol){
        self.service = service
    }
    
    func viewDidLoad(){
        getTrendingMovies()
        loadMoreDta()
    }
    
    //MARK: COUNT FOR CELL
    func numberOfRows() -> Int {
        return searchedMovie.count
    }
    
    //MARK: DATA FOR CELL
    func movieContent() -> [TrendingMovie]{
        return searchedMovie
    }
    
    
    func getTrendingMovies(){
        guard currentPage <= totalPages else { return }
        isLoading = true
        service.getTrendingMovies(page: currentPage)
            .receive(on: DispatchQueue.main)
            .map({$0.results})
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion{
                case .finished : break
                case .failure(let error):
                    self?.errorPublisher.send(error)
                }
            } receiveValue: { [weak self] returnedMovies in
                
                self?.movies.append(contentsOf: returnedMovies)
                self?.searchedMovie.append(contentsOf: returnedMovies)
                self?.currentPage += 1
            }
            .store(in: &cancellables)
    }
        func loadMoreDta(){
            service.getTrendingMovies(page: currentPage)
                .receive(on: DispatchQueue.main)
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
                        print( "\total\(self?.totalPages)")
                    }
                    .store(in: &cancellables)

                
        }

    
    #warning("search doesn't work")
    func updateSearch(text : String){
        if text.isEmpty{
            searchedMovie = movies
        }else{
            searchedMovie = movies.filter{ ($0.title )!.lowercased().contains(text.lowercased())}
        }
        isSearching = !text.isEmpty
        
    }
    
    
 
    
    
}

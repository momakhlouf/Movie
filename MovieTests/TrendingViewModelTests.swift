//
//  TrendingViewModelTests.swift
//  MovieTests
//
//  Created by Mohamed Makhlouf Ahmed on 15/03/2023.
//

import XCTest
@testable import Movie
import Combine

final class TrendingViewModelTests: XCTestCase {
    
    var moviesService: MockService!
    var viewModel: TrendingViewModel!
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        
        moviesService = MockService()
        viewModel = TrendingViewModel(network: moviesService)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        moviesService = nil
        viewModel = nil
        cancellables.removeAll()
    }
    
    
    
    func test_TrendingViewModel_moviesArray_shouldNotBeEmpty(){
        
        //Given
        //   let expectation = self.expectation(description: "Movies are fetched successfully")
        //when
        viewModel.$searchedMovie
            .dropFirst()
            .sink { movies in
                //     expectation.fulfill()
                XCTAssertFalse(movies.isEmpty)
                XCTAssertEqual(movies.count,2)
            }
            .store(in: &cancellables)
        //viewModel.getMovies()
        
        // Then
        //   wait(for: [expectation], timeout: 5)
        // XCTAssertEqual(viewModel.movies.count,2)
        
    }
    
    func test_TrendingViewModel_moviesArray_shouldNotBeEmpty2(){
        
        //Given
           let expectation = self.expectation(description: "Movies are fetched successfully")
        //when
        viewModel.$searchedMovie
            .dropFirst()
            .sink { movies in
                     expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
           wait(for: [expectation], timeout: 5)
           XCTAssertEqual(viewModel.movies.count,2)
        
    }
    
 
    func test_TrendingViewModel_NumberOfRows_ShouldBeEqualTrendingMoviesCount(){
        let rows = moviesService.trendingMovies.count
        viewModel.searchedMovie = moviesService.trendingMovies
        
        let numOfRows  = viewModel.numberOfRows()
        XCTAssertEqual(numOfRows, rows)
    }
    
    func testMovie_TrendingViewModel_MovieContent() {
        // Given
        let expectedMovies = moviesService.trendingMovies
        viewModel.searchedMovie = expectedMovies
        
        // When
        let movies = viewModel.movieContent()
        
        print(viewModel.movieContent().count)
        // Then
        XCTAssertEqual(movies, expectedMovies)
    }
    
    
    
    
}

//
//  TrendingViewModelTests.swift
//  MovieTests
//
//  Created by Mohamed Makhlouf Ahmed on 12/03/2023.
//

import XCTest
@testable import Movie
import Combine

//Naming Structure: test_[struct or class]_[variable or func UnderTest]_[ExpectedResult]
//Testing Structure: Given, when, then
final class TrendingServiceTests: XCTestCase {

    //
    var moviesService: MockService!

    
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
  
        moviesService = MockService()
    }

    override func tearDownWithError() throws {
        //
        moviesService = nil
    }
     
    
    
    func test_Service_GetTrendingMovies_return2(){
   
        //when
        let expectation = XCTestExpectation()
        var newMovies : [TrendingMovie] = []
        //then
        moviesService.getTrendingMovies(page: 1)
            .sink { completion in
                switch completion {
                case .finished :
                    expectation.fulfill() 
                case .failure :
                    XCTFail()
                }
            } receiveValue: { returnedMovies in
                newMovies = returnedMovies
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(newMovies.count, moviesService.trendingMovies.count)

    }
    
//    func testFetchMovies(){
//        let promise = expectation(description: "Fetch movies success")
//
//        viewModel.$searchedMovie
//            .sink { movies in
//                if !movies.isEmpty{
//                    promise.fulfill()
//                }
//            }
//            .store(in: &cancellables)
//
//        waitForExpectations(timeout: 5, handler: nil)
//    }
//
//
//    func testGetTrendingMovies(){
//        let expectation = XCTestExpectation(description: "get trending")
//
//        viewModel.$movies
//            .dropFirst()
//            .sink { movies in
//                XCTAssertEqual(movies.count, 2)
//                XCTAssertEqual(movies[0].title, "one")
//                expectation.fulfill()
//            }
//            .store(in: &cancellables)
//
//        wait(for: [expectation], timeout: 5.0)
//
//    }
//
//    func testFetchingMockData(){
//        moviesService.getUpcomingMovies()
//            .sink { _ in
//
//            } receiveValue: { movies in
//                XCTAssertEqual(movies.count, 2)
//            }
//            .store(in: &cancellables)
//
//    }

}

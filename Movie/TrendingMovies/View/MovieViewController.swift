//
//  MovieViewController.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 06/03/2023.
//

import UIKit
import Combine

class MovieViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    private let viewModel : TrendingViewModel
    var cancellable = Set<AnyCancellable>()
    let searchController = UISearchController(searchResultsController: nil)

    init(service : ServiceProtocol){
        viewModel = TrendingViewModel(service: service)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        searchBarConfigure()
        setupViewModelBinding()
        configView()
        viewModel.isLoading = true
        setupTableView()
        
    }
}

extension MovieViewController {
    func configView(){
        self.title = "Trending"
        setupTableView()
    }
    
    func setupTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
}
//MARK: VIEW MODEL BINDINGS
private extension MovieViewController {
    func setupViewModelBinding(){
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] _ in self?.tableView.reloadData() }
            .store(in: &cancellable)

        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.indicator.startAnimating()
                    self?.tableView.isHidden = true
                } else {
                    
                    self?.indicator.stopAnimating()
                    self?.indicator.hidesWhenStopped = true
                    self?.tableView.isHidden = false
                }
            }
            .store(in: &cancellable)
        
        viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
            .store(in: &cancellable)
        
        viewModel.$searchedMovie
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellable)
    }
}

//MARK: SEARCHBAR DELEGATE
extension MovieViewController : UISearchBarDelegate {
    
    func searchBarConfigure(){
        searchController.loadViewIfNeeded()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search by movie name here..."
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateSearch(text: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //searchBar.text = ""
        viewModel.updateSearch(text: "")
        searchBar.resignFirstResponder()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension MovieViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        //cell.selectionStyle = .none
        cell.didTapFav = { [weak self] in
         // fav button
        }
         cell.selectionStyle = .none
         cell.configureCell(movie: viewModel.movieContent()[indexPath.row])
                 
        return cell
    }
    
    
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        print(viewModel.isSearching.description)
        if !viewModel.isSearching && offsetY > contentHeight - frameHeight {
            // Load more data
            viewModel.getTrendingMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movieContent()[indexPath.row]
        let detailsVC = AppRouter.createTrendingDetails(movie: movie)
        navigationController?.pushViewController(detailsVC, animated: true)
    }

}

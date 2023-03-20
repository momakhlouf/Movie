//
//  UpcomingMoviesViewController.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 13/03/2023.
//

import UIKit
import Combine

class UpcomingMoviesViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    private let viewModel : UpcomingMoviesViewModel
    private var dataSource : UITableViewDiffableDataSource<Section,UpcomingMovie>!
    var cancellables = Set<AnyCancellable>()

    init(service: ServiceProtocol) {
        self.viewModel = UpcomingMoviesViewModel(network: service)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setUpViewModelBindings()
        setupTableView()
        setupUI()
        configureDataSource()
      //  viewModel.isLoading = true

    }
}

extension UpcomingMoviesViewController {
    func setupUI(){
        self.title = "Upcoming"
    }
    func setupTableView(){
        tableView.delegate = self
        tableView.register(UINib(nibName: "UpcomingMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}

//MARK: VIEW MODEL BINDINGS
private extension UpcomingMoviesViewController {
    func setUpViewModelBindings(){
        viewModel.$upcomingMovies
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] _ in
                self?.tableView.reloadData()
                self?.createSnapShot()
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.indicator.startAnimating()
                    self?.tableView.isHidden = true
                }else{
                    self?.indicator.stopAnimating()
                    self?.indicator.hidesWhenStopped = true
                    self?.tableView.isHidden = false
                }
            }
            .store(in: &cancellables)
        
        viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showAlert(title: "No Movies", message: "Sorry, there are no movies to display at the moment. Please try again later or check back soon.")
            }
            .store(in: &cancellables)
    }
}


//MARK: DIFFABLE DATA SOURCE
private extension UpcomingMoviesViewController {
    func configureDataSource(){
        dataSource = UITableViewDiffableDataSource<Section,UpcomingMovie>(tableView: tableView, cellProvider: { tableView, indexPath, movie in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UpcomingMovieTableViewCell
            cell.selectionStyle = .none

            cell.configureUpcomingCell(movie: self.viewModel.moviesContent()[indexPath.row])
            return cell
        })
    }
    
    func createSnapShot(){
         var movieSnapshot = NSDiffableDataSourceSnapshot<Section, UpcomingMovie>()
        movieSnapshot.appendSections([.main])
        movieSnapshot.appendItems(viewModel.upcomingMovies)
        dataSource.apply(movieSnapshot, animatingDifferences: true)

    }
}

//MARK: TABLE VIEW DELEGATE
extension UpcomingMoviesViewController : UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print("selected")
    }
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        if offsetY > contentHeight - frameHeight{
//            !viewModel.isSearching &&
            viewModel.getUpcomingMovies()
        }
    }
}

//MARK: SECTION FOR DIFFABLE DATA SOURCE
extension UpcomingMoviesViewController {
    enum Section {
        case main
    }
}



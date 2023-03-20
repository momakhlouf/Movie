//
//  FavoriteViewController.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 19/03/2023.
//

import UIKit
import Combine
class FavoriteViewController: UIViewController {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var cancellables = Set<AnyCancellable>()
    let viewModel : FavoriteMoviesViewModel
    
    private var dataSource : UITableViewDiffableDataSource<Section,FavoriteMovie>!

    init(viewModel : FavoriteMoviesViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpViewModelBindings()
        setupTableView()
        configureDataSource()
        print(viewModel.fetchFavorite().count)
        emptyView.isHidden = true
        print(viewModel.favoriteMovies)
        setupEmptyView()
    }

    //MARK: MOVE TO TRENDING.
    @IBAction func addToFavoritesIfEmpty(_ sender: UIButton) {
     //move to trending
    }
}


//MARK: VIEW MODEL BINDINGS
extension FavoriteViewController{
    func setUpViewModelBindings(){
        viewModel.$favoriteMovies
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.createSnapShot()
            }
            .store(in: &cancellables)
    }
}

//MARK: CONFIGURE UI
extension FavoriteViewController {
   func setupEmptyView(){
       print("status \(viewModel.isTableViewEmpty().description)")
       if viewModel.isTableViewEmpty() {
           emptyView.isHidden = false
           tableView.isHidden = true
       }else{
           emptyView.isHidden = true
           tableView.isHidden = false
       }
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}

//MARK: DIFFABLE DATA SOURCE
extension FavoriteViewController {
    
    func configureDataSource(){
         dataSource = UITableViewDiffableDataSource<Section, FavoriteMovie>(tableView: tableView, cellProvider: { tableView, indexPath, movie in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell//UpcomingMovieTableViewCell
             
            cell.selectionStyle = .none
            cell.configureFavoriteCell(movie: self.viewModel.fetchFavorite()[indexPath.row])
            return cell
        })
    }
    
    func createSnapShot(){
        guard let dataSource = dataSource else {
            print("nilll")
               return // dataSource is nil, so exit early
           }
        var movieSnapShot = NSDiffableDataSourceSnapshot<Section, FavoriteMovie>()
        movieSnapShot.appendSections([.main])
        movieSnapShot.appendItems(viewModel.favoriteMovies)
        dataSource.apply(movieSnapShot,animatingDifferences: true)
    }
}

//MARK: TABLEVIEW DELEGATE AND DELETING
extension FavoriteViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
 
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            guard let deletedMovie = self.dataSource.itemIdentifier(for: indexPath) else {
                completion(false)
                return
            }
            
            self.viewModel.deleteFromFavorite(indexPath: indexPath)

            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([deletedMovie])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            print(self.viewModel.favoriteMovies.count)
          //  tableView.reloadData()
            self.setupEmptyView()

            completion(true)
            tableView.reloadData()

        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

//MARK: SECTION FOR DIFFABLE DATA SOURCE
extension FavoriteViewController {
    enum Section {
        case main
    }
}


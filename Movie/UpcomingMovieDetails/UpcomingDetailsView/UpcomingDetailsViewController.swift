//
//  UpcomingDetailsViewController.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 20/03/2023.
//

import UIKit

class UpcomingDetailsViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieOverView: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    let viewModel : UpcomingDetailsViewModel
    
    init(viewModel : UpcomingDetailsViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        setupView()
    }


    func setupView(){
        movieImage.loadImage(viewModel.movieImage)
        movieTitle.text = viewModel.movieTitle
        movieOverView.text = viewModel.movieOverView
    }
}

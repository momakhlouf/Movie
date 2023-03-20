//
//  TrendingMoviesDetailsViewController.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 08/03/2023.
//

import UIKit
import Kingfisher
class TrendingMoviesDetailsViewController: UIViewController {

    //IBOUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
     
    var viewModel : TrendingDetailsViewModel
    var movieId : Int = 0
    
    init(viewModel : TrendingDetailsViewModel){
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
        titleLabel.text = viewModel.movieTitle
        descriptionLabel.text = viewModel.movieOverView
        imageView.loadImage(viewModel.movieImage)
      
    }



}

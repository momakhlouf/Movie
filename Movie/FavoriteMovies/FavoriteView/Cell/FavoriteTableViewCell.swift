//
//  MovieTableViewCell.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 06/03/2023.
//

import UIKit
import Kingfisher

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var didTapFav: (()->())?

    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        backView.round()
        backView.addBorder(color: .label, width: 1)
        MovieImage.round(5)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(movie : TrendingMovie){
        movieTitle.text = movie.name ??  movie.title ?? ""
        print(movie.title)
        rate.text = "⭐️\(String(format: "%.1f", movie.voteAverage ?? 0))/10"
        date.text = movie.releaseDate ?? movie.firstAirDate ?? ""
        MovieImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w400/\(movie.posterPath)"))
    }
    func configureFavoriteCell(movie : FavoriteMovie){
        MovieImage.kf.setImage(with: URL(string: movie.photo ?? ""))
        movieTitle.text = movie.title
        date.text = movie.date
        rate.text = "⭐️\(String(format: "%.1f", movie.rate))/10"
    }
    
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        didTapFav?()
        
    }
}

//
//  UpcomingMovieTableViewCell.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 13/03/2023.
//

import UIKit

class UpcomingMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var didTapFav: (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()

        backView.round()
        backView.addBorder(color: .label, width: 1)
        movieImage.round(5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUpcomingCell(movie : UpcomingMovie){
        titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate
        rateLabel.text = "⭐️\(String(format: "%.1f", movie.voteAverage ?? 0))/10"
        if let poster = movie.posterURL {
            movieImage.loadImage(poster)
        }
     
    }
    
    func configureTrendingCell(movie : TrendingMovie){
        titleLabel.text = movie.name ??  movie.title ?? "No Name"
        dateLabel.text = movie.releaseDate ?? movie.firstAirDate ?? ""
        rateLabel.text = "⭐️\(String(format: "%.1f", movie.voteAverage ?? 0))/10"

        if let poster = movie.posterURL {
            movieImage.loadImage(poster)
        }
        
    }
    
    
    func configureFavoriteCell(movie : FavoriteMovie){
        titleLabel.text = movie.title
        dateLabel.text = movie.date
        rateLabel.text = "⭐️\(String(format: "%.1f", movie.rate))/10"
    }
    
    
    @IBAction func addFavoriteButtonPressed(_ sender: UIButton) {
        didTapFav?()
    }
    
//    MovieImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w400/\(movie.posterPath)"))
    
    
//    didTapFav?()

}





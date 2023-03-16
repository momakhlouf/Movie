//
//  UpcomingMovieTableViewCell.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 13/03/2023.
//

import UIKit
import Kingfisher
class UpcomingMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
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
    
    func configureCell(movie : UpcomingMovie){
        titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate
       // rateLabel.text = "⭐️\(String(format: "%.1f", movie.voteAverage))/10"
        
       // movieImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w400\(movie.posterPath)"))
        if let poster = movie.posterURL {
            movieImage.kf.setImage(with: URL(string: poster))
        }else{
            movieImage.image = UIImage(systemName: "heart.fill")
        }
     
    }
    
}

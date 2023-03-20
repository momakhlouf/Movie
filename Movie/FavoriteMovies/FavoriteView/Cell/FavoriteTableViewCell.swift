//
//  MovieTableViewCell.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 06/03/2023.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var date: UILabel!
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
      
        backView.round()
        backView.addBorder(color: .label, width: 1)
        MovieImage.round(5)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureFavoriteCell(movie : FavoriteMovie){
        MovieImage.loadImage(movie.photo)
       // MovieImage.kf.setImage(with: URL(string: movie.photo ?? ""))
        movieTitle.text = movie.title
        date.text = movie.date
        rate.text = "⭐️\(String(format: "%.1f", movie.rate))/10"
    }
}

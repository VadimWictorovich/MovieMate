//
//  MovieListTVCell.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 22.01.24.
//

import UIKit

class MovieListTVCell: UITableViewCell {
    
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var ratingMovieLabel: UILabel!
    @IBOutlet weak var descriptionMovielabel: UILabel!


    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

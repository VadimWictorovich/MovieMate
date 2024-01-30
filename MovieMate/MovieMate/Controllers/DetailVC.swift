//
//  DetailVC.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 28.11.23.
//

import UIKit

final class DetailVC: UIViewController {


    // TODO: - Данные не приходят, пересмотреть и переделать
    var movie: MovieDetail? {
        didSet {
            stopActivityAnimation()
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameMovieLbl: UILabel!
    @IBOutlet weak var alternativeNameMovieLbl: UILabel!
    @IBOutlet weak var yearMovieLbl: UILabel!
    @IBOutlet weak var descriptionMovieLbl: UILabel!
    @IBOutlet weak var sloganMovieLbl: UILabel!
//    @IBOutlet weak var ratingMovieLbl: UILabel!
//    @IBOutlet weak var genresMovieLbl: UILabel!
    

    override func loadView() {
        super.loadView()
        startActivityAnimation()
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        guard let movie else { return }
        
    }

}

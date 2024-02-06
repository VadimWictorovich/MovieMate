//
//  DetailVC.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 28.11.23.
//

import UIKit

final class DetailVC: UIViewController {


    // TODO: - Данные не приходят, пересмотреть и переделать
    var movie: MovieDetail?
    var movieId: Int?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameMovieLbl: UILabel!
    @IBOutlet weak var alternativeNameMovieLbl: UILabel!
    @IBOutlet weak var yearMovieLbl: UILabel!
    @IBOutlet weak var descriptionMovieLbl: UILabel!
    @IBOutlet weak var sloganMovieLbl: UILabel!
//    @IBOutlet weak var ratingMovieLbl: UILabel!
//    @IBOutlet weak var genresMovieLbl: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        guard let movie, let urlString = movie.poster?.url, let url = URL(string: urlString) else {
            print("movie равен нил")
            return }
        DispatchQueue.main.async { [weak self] in
            self?.getImage(url: url)
            self?.nameMovieLbl.text = movie.name
            self?.alternativeNameMovieLbl.text = "альтернативное название: \(movie.enName ?? "нет данных")"
            self?.yearMovieLbl.text = "год выпуска: \(movie.year?.description ?? "нет данных")"
            self?.sloganMovieLbl.text = movie.slogan
            self?.descriptionMovieLbl.text = movie.description
        }
    }
    
    private func getImage(url: URL) {
        NetworkService.fetchMovieImage(imageURL: url) { [weak self] result, error in
            if let error {
                print("в методе getImage класса DetailVC получена ошибка: \(error)")
                return
            } else if let result, let self {
                self.imageView.image = result
            }
        }
    }
}

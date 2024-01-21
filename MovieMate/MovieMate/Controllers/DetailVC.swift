//
//  DetailVC.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 28.11.23.
//

import UIKit

final class DetailVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameMovieLbl: UILabel! {
        didSet {
            nameMovieLbl.text = movie?.name ?? "Данных нет"
        }
    }
    @IBOutlet weak var alternativeNameMovieLbl: UILabel!
    @IBOutlet weak var yearMovieLbl: UILabel!
    @IBOutlet weak var descriptionMovieLbl: UILabel!
    @IBOutlet weak var sloganMovieLbl: UILabel!
//    @IBOutlet weak var ratingMovieLbl: UILabel!
//    @IBOutlet weak var genresMovieLbl: UILabel!
    // TODO: - Данные не приходят, пересмотреть и переделать
    var movie: MovieDetail? {
        didSet {
            stopActivityAnimation()
        }
    }

    override func loadView() {
        super.loadView()
        startActivityAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
//        guard let movie else {
//            print("Ошибка в методе updateUI: объект фильма не инициализирован")
//            return }
//        nameMovieLbl.text = movie.name ?? "Название отсутствует"
//        yearMovieLbl.text = "Год выпуска: \(movie.year?.description ?? "Сведения отсутствуют")"
//        alternativeNameMovieLbl.text = "Год выпуска: \(movie.alternativeName ?? "Сведения отсутствуют")"
//        descriptionMovieLbl.text = "Год выпуска: \(movie.description ?? "Сведения отсутствуют")"
//        sloganMovieLbl.text = "Год выпуска: \(movie.slogan ?? "Сведения отсутствуют")"
    }

}

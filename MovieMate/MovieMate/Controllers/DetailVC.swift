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
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameMovieLbl: UILabel!
    @IBOutlet private weak var yearMovieLbl: UILabel!
    @IBOutlet private weak var alternativeNameMovieLbl: UILabel!
    @IBOutlet private weak var enName: UILabel!
    @IBOutlet private weak var sloganMovieLbl: UILabel!
    @IBOutlet private weak var rating: UILabel!
    @IBOutlet private weak var ageRating: UILabel!
    @IBOutlet private weak var movieLength: UILabel!
    @IBOutlet private weak var genres: UILabel!
    @IBOutlet private weak var persons: UILabel!
    @IBOutlet private weak var descriptionMovieLbl: UILabel!

    private var genresArr: [String] = []
    private var personsArr: [String] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.title = "Описание"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "house.circle.fill"), style: .plain, target: self, action: #selector(goToRootVC))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2740662098, green: 0.8547341824, blue: 0.7583532929, alpha: 1)
        guard let movie, let urlString = movie.poster?.url,
              let url = URL(string: urlString)
        else {
            print("movie равен нил")
            return }
        if let genr = movie.genres, let actors = movie.persons, let rating = movie.rating {
            genr.forEach { val in
                guard let nameGenr = val.name else { return }
                genresArr.append(nameGenr)
            actors.forEach { val in
                if let act = val.name { personsArr.append(act) }
                else if let enAct = val.enName { personsArr.append(enAct) }
                }
            }
            
        }
            DispatchQueue.main.async { [weak self] in
                self?.genres.text = "Жанр: \(self?.genresArr.joined(separator: ", ") ?? "сведения отсутствуют")"
                self?.persons.text = "В ролях: \(self?.personsArr.joined(separator: ", ") ?? "сведения отсутствуют")"
                self?.getImage(url: url)
                self?.nameMovieLbl.text = movie.name ?? "сведения отсутствуют"
                self?.yearMovieLbl.text = "Год выпуска: \(movie.year?.description ?? "сведения отсутствуют")"
                self?.alternativeNameMovieLbl.text = "Альтернативное название: \(movie.alternativeName ?? "сведения отсутствуют")"
                self?.enName.text = "Оригинальное название: \(movie.enName ?? "сведения отсутствуют")"
                self?.sloganMovieLbl.text = "Слоган: '\(movie.slogan ?? "сведения отсутствуют")'"
                self?.rating.text = "Рейтинги: \(movie.rating?.imdb?.description ?? "0.0") (IMDb), \(movie.rating?.tmdb?.description ?? "0.0") (TMDB), \(String(format: "%.1f", movie.rating?.kp ?? "0.0")) (kinopoisk), \(movie.rating?.filmCritics?.description ?? "0.0") (filmCritics), \(movie.rating?.russianFilmCritics?.description ?? "0.0") (russianFilmCritics)"
                self?.ageRating.text = "Ограничение по возрасту: \(movie.ageRating?.description ?? "сведения отсутствуют")+"
                self?.movieLength.text = "Продолжительность: \(movie.movieLength?.description ?? "сведения отсутствуют") мин."
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
    
    @objc private func goToRootVC() {
    navigationController?.popToRootViewController(animated: true)
    }
}







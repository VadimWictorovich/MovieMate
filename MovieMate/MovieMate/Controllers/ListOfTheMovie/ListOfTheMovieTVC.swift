//
//  ListOfTheMovieTVC.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 11.01.24.
//

import UIKit

class ListOfTheMovieTVC: UITableViewController {
    
    var movieList: [MovieDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellList", for: indexPath) as? MovieListTVCell
        else { return UITableViewCell() }
        let movie = movieList[indexPath.row]
        cell.nameMovieLabel.text = (movie.name ?? "Нет данных") + " " + (movie.year?.description ?? " ")
        cell.ratingMovieLabel.text = "Рейтинг: \(String(format: "%.1f", movie.rating?.kp ?? "0.0")) (kp)"
        cell.descriptionMovielabel.text = "\(movie.ageRating?.description ?? "6")+"
        DispatchQueue.main.async {
            guard let urlString = movie.poster?.previewUrl, let url = URL(string: urlString) else {
                print ("в методе cellForItemAtIndexPath класса ListOfTheMovieTVC не получена urlImage")
                return
            }
            NetworkService.fetchMovieImage(imageURL: url) { result, error in
                if let error {
                    print("в методе cellForItemAtIndexPath класса ListOfTheMovieTVC получена ошибка: \(error)")
                } else if let result {
                    DispatchQueue.main.async {
                        cell.movieImageView.image = result
                        cell.setNeedsLayout()
                    }
                }
            }
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieList[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC {
            vc.movie = movie
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    private func setupUI() {
        navigationItem.title = "Список фильмов"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "house.circle.fill"), style: .plain, target: self, action: #selector(goToRootVC))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2740662098, green: 0.8547341824, blue: 0.7583532929, alpha: 1)
        
    }
    
    
    @objc func goToRootVC() {
        navigationController?.popToRootViewController(animated: true)
    }
}


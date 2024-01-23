//
//  ListOfTheMovieTVC.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 11.01.24.
//

import UIKit

class ListOfTheMovieTVC: UITableViewController {
    
    var word: String?
    private var movieList: [MovieDetail] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getValue()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellList", for: indexPath) as? MovieListTVCell 
        else { return UITableViewCell() }
        let movie = movieList[indexPath.row]
        cell.nameMovieLabel.text = (movie.enName ?? "Нет данных") + " " + (movie.year?.description ?? " ")
        cell.descriptionMovielabel.text = movie.slogan
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func getValue() {
        guard let word else { return }
        NetworkService.fetchMovieByWord(word: word) { [weak self] result, error in
            if let error {
                print("* * * * В методе getValue класса ListOfTheMovieTVC получена ошибка: \(error) * * *")
            }
            guard let result, let self else { return }
                print("* * * * В методе getValue класса ListOfTheMovieTVC получен result: \(result) * * *")
            self.movieList = result.docs
            self.tableView.reloadData()
        }
    }
}

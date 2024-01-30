//
//  ListOfTheMovieTVC.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 11.01.24.
//

import UIKit

class ListOfTheMovieTVC: UITableViewController {
    
    var movieList: [MovieDetail] = []
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellList", for: indexPath) as? MovieListTVCell
        else { return UITableViewCell() }
        if movieList.isEmpty { print ("movieList пустой") }
        let movie = movieList[indexPath.row]
        cell.nameMovieLabel.text = (movie.name ?? "Нет данных") + " " + (movie.year?.description ?? " ")
        cell.descriptionMovielabel.text = movie.slogan
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


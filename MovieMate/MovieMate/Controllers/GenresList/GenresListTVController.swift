//
//  GenresListTVController.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 22.01.24.
//

import UIKit

class GenresListTVController: UITableViewController {
    
    
    var genres: [Genre] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGenresList()
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        genres.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellGenres", for: indexPath)
        let genre = genres[indexPath.row]
        cell.textLabel?.text = genre.name
        return cell
    }
    
    
    // MARK: - Function
    private func getGenresList() {
        NetworkService.fetchGenresList { result, error in
            if let error {
                print("* * * * * * Ошибка при получении данных в методе getGenresList класса HomeTVController: \(error) * * * *")
            } 
            guard let result else { return }
                print("* * * * Получен массив жанров: \(result) * * *")
                self.genres = result
                self.tableView.reloadData()
        }
    }
}

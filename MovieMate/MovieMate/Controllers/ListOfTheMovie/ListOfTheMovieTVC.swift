//
//  ListOfTheMovieTVC.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 11.01.24.
//

import UIKit

class ListOfTheMovieTVC: UITableViewController {
    
    var word: String?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellList", for: indexPath) as? MovieListTVCell 
        else { return UITableViewCell() }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func getValue() {
        NetworkService.fetchMovieByWord { result, error in
            if let error {
                print("* * * * В методе getValue класса ListOfTheMovieTVC получена ошибка: \(error) * * *")
            } else if let result {
                print("* * * * В методе getValue класса ListOfTheMovieTVC получен result: \(result) * * *")
            }
        }
    }
}

//
//  HomeTVControllerTableViewController.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 22.11.23.
//

import UIKit


enum NameSection: String, CaseIterable {
    case rootSection = "Главное меню"
    case bestForYearSection = "Лучшее за 2023 год"
    case bestAllTimeSection = "Лучшее за всю историю"
}

enum NameCellAction: String, CaseIterable {
    case firstButName = "Поиск фильмов по ключевым словам"
    case secondButName = "Поиск фильмов по жанрам"
    case thirdButName = "Случайный выбор фильма"
    case fourthButName = "Сейчас в кино"
}

class HomeTVController: UITableViewController {
    
    private let buttonNamed = NameCellAction.allCases
    private let sectionNamed = NameSection.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionNamed.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionNamed[section].rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sectionNamed[section] {
        case .rootSection:
            return buttonNamed.count
        case .bestForYearSection:
            return 1
        case .bestAllTimeSection:
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let but = buttonNamed[indexPath.row]
        cell.textLabel?.text = but.rawValue
        return cell
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

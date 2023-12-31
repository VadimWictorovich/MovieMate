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
    case bestAllTimeSection = "Лучшее за все время"
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
        tableView.register(BestMoviesInYearTVCell.self, forCellReuseIdentifier: "cellInCollection1")
        tableView.register(AllTimeTVCell.self, forCellReuseIdentifier: "cellInCollection2")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionNamed.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionNamed[section].rawValue
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
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
        
        switch sectionNamed[indexPath.section] {
        case .rootSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameButton", for: indexPath)
            let but = buttonNamed[indexPath.row]
            cell.textLabel?.text = but.rawValue
            cell.textLabel?.textColor = .white
            return cell
        case .bestForYearSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellInCollection1", for: indexPath) as? BestMoviesInYearTVCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        case .bestAllTimeSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellInCollection2", for: indexPath) as? AllTimeTVCell else { return UITableViewCell() }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch sectionNamed[indexPath.section] {
        case .rootSection:
            return 60.0
        case .bestForYearSection:
            return 200.0
        case .bestAllTimeSection:
            return 200.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        switch buttonNamed[indexPath.row] {
        case .firstButName:
            guard let vc = sb.instantiateViewController(withIdentifier: "SeatchByWordsVC") as? SeatchByWordsVC else { return }
            navigationController?.pushViewController(vc, animated: true)
        case .secondButName: break
            
        case .thirdButName: break
            
        case .fourthButName: break
            
        }
    }
}

extension HomeTVController: PushToVC {
    func didSelectCell(at indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}



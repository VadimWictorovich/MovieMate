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

final class HomeTVController: UITableViewController {
    
    private let buttonNamed = NameCellAction.allCases
    private let sectionNamed = NameSection.allCases
    private lazy var searchView = SeatchByWordsView()
    private lazy var randomMovie = RandomMovieView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(BestMoviesInYearTVCell.self, forCellReuseIdentifier: "cellInCollection1")
        tableView.register(AllTimeTVCell.self, forCellReuseIdentifier: "cellInCollection2")
    }

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
        switch buttonNamed[indexPath.row] {
        case .firstButName:
            showSearchView()
        case .secondButName:
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = sb.instantiateViewController(withIdentifier: "ListOfTheMovieTVC") as? ListOfTheMovieTVC {
                navigationController?.pushViewController(vc, animated: true)
            }
        case .thirdButName:
            startActivityAnimation(message: "Загрузка...", type: .ballScaleMultiple, color: .white, textColor: .white)
            getRandomMovie()
        case .fourthButName:
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = sb.instantiateViewController(withIdentifier: "ListOfTheMovieTVC") as? ListOfTheMovieTVC {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    private func showSearchView() {
        searchView.frame.size = CGSize(width: 320, height: 250)
        searchView.center.x = view.center.x
        searchView.transform = CGAffineTransform(scaleX: 3.9, y: 0.2)
        view.addSubview(searchView)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0) { [weak self] in
            self?.searchView.transform = .identity
        }
    }
    
    private func showRandomMovieView() {
        randomMovie.frame.size = CGSize(width: 320, height: 400)
        randomMovie.center.x = view.center.x
        randomMovie.transform = CGAffineTransform(scaleX: 3.9, y: 0.2)
        view.addSubview(randomMovie)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0) { [weak self] in
            self?.randomMovie.transform = .identity
        }
    }
    
    private func getRandomMovie() {
       let queue = DispatchQueue.global(qos: .utility)
       queue.async {
           NetworkService.fetchRandomMovie { [weak self] result, error in
               if let error = error {
                   print("Ошибка при получении данных: \(error)")
                   return
               }
               guard let self, let result = result else {
                   print("Ошибка: получены некорректные данные")
                   return
               }
               print("Получен случайный фильм: \(result.name)")
               DispatchQueue.main.async { [weak self] in
                   self?.showRandomMovieView()
                   self?.randomMovie.movie = result
                   self?.randomMovie.updateUIWithMovie()
                   self?.stopActivityAnimation()
               }
           }
       }
   }
    
    @objc func closeSearchView() {
        searchView.removeFromSuperview()
    }
    
    @objc func closeRandomMovieView() {
        randomMovie.removeFromSuperview()
    }
    
    @objc func showRandomMovie() {
        getRandomMovie()
        startActivityAnimation(message: "Загрузка...", type: .ballScaleMultiple, color: .white, textColor: .white)
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




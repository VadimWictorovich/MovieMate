//
//  HomeTVControllerTableViewController.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 22.11.23.
//

import UIKit


// MARK: - ENUMS
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


// MARK: - ViewController
final class HomeTVController: UITableViewController {
    
    
    // MARK: Properties
    private let buttonNamed = NameCellAction.allCases
    private let sectionNamed = NameSection.allCases
    private let blurEf = UIBlurEffect(style: .regular)
    private lazy var searchView = SeatchByWordsView()
    private lazy var randomMovie = RandomMovieView()
    private lazy var genresList = GenresListTVController()
    private lazy var blurEfVeiw = UIVisualEffectView(effect: blurEf)
    
    // MARK: Lifecycle VC
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
            cell.delegate = self
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
            if let vc = sb.instantiateViewController(withIdentifier: "GenresListTVController") as? GenresListTVController {
                vc.navigationItem.title = "Жанры"
                navigationController?.pushViewController(vc, animated: true)
            }
        case .thirdButName:
            startActivityAnimation()
            getRandomMovie()
        case .fourthButName:
            goPremiereMovie()
        }
    }
    
    
    // MARK: - Methods
    func showSearchView() {
        blurEffect()
        searchView.frame.size = CGSize(width: 320, height: 250)
        searchView.center.x = view.center.x
        searchView.transform = CGAffineTransform(scaleX: 3.9, y: 0.2)
        searchView.delegate = self
        searchView.delegateClosed = self
        view.addSubview(searchView)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0) { [weak self] in
            self?.searchView.transform = .identity
        }
    }
    
    private func showRandomMovieView() {
        blurEffect()
        randomMovie.frame.size = CGSize(width: 320, height: 600)
        randomMovie.center.x = view.center.x
        randomMovie.transform = CGAffineTransform(scaleX: 3.9, y: 0.2)
        randomMovie.delegate = self
        randomMovie.delegateClosed = self
        view.addSubview(randomMovie)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0) { [weak self] in
            self?.randomMovie.transform = .identity
        }
    }
    
    private func getRandomMovie() {
        NetworkService.fetchRandomMovie { result, error in
            if let error = error {
                print("* * * * Ошибка при получении данных в методе getRandomMovie: \(error) * * *")
                return
            } else if let result {
                print("* * * * Получен случайный фильм: \(result.name) * * *")
                DispatchQueue.main.async { [weak self] in
                    self?.showRandomMovieView()
                    self?.randomMovie.movie = result
                    self?.randomMovie.updateUIWithMovie()
                    self?.stopActivityAnimation()
                }
            }
            print("* * * * Ошибка: получены некорректные данные в методе getRandomMovie * * *")
        }
    }
    
    
    private func goPremiereMovie() {
        NetworkService.fetchMoviePrimere { [weak self] result, error in
            if let error = error {
                print("* * * * Ошибка при получении данных в методе getRandomMovie: \(error) * * *")
                return
            } else if let result, let self {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                if let vc = sb.instantiateViewController(withIdentifier: "ListOfTheMovieTVC") as? ListOfTheMovieTVC {
                    vc.movieList = result.docs
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    private func blurEffect() {
        blurEfVeiw.frame = view.bounds
        view.addSubview(blurEfVeiw)
    }
    
    
    private func cancelBlurEffect() {
        blurEfVeiw.removeFromSuperview()
    }
                                         
    
    // MARK: Objs methods
    @objc func closeSearchView() {
        searchView.removeFromSuperview()
        cancelBlurEffect()
    }
    
    @objc func closeRandomMovieView() {
        randomMovie.removeFromSuperview()
        cancelBlurEffect()
    }
    
    @objc func showRandomMovie() {
        getRandomMovie()
        startActivityAnimation()
    }
}


// MARK: - Extentions VC
extension HomeTVController: PushToVC, DelegateGoToListMovieDetail, DelegateGoToMovieDetail, DelegateClosedView {
    func closedView() {
        searchView.removeFromSuperview()
        randomMovie.removeFromSuperview()
        cancelBlurEffect()
    }
    
    
    func openVCMovieDetail(at indexPath: IndexPath?, detail: MovieDetail?, movieId: Int?) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC {
            vc.movie = detail
            vc.movieId = movieId
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func openTVCListMovies(list: [MovieDetail]) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "ListOfTheMovieTVC") as? ListOfTheMovieTVC {
            vc.movieList = list
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func openVC(at indexPath: IndexPath?, identifier: String) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
}




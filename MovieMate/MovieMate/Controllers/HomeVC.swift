//
//  HomeVC.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 20.11.23.
//

import UIKit

enum ElemetsNameTV: String, CaseIterable {
    case firstButName = "Поиск фильмов по ключевым словам"
    case secondButName = "Поиск фильмов по жанрам"
    case thirdButName = "Случайный выбор фильма"
    case fourthButName = "Сейчас в кино"
}

final class HomeVC: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    private let buttonNamed = ElemetsNameTV.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        buttonNamed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = buttonNamed[indexPath.row].rawValue
        cell.textLabel?.text = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = buttonNamed[indexPath.row]
        switch item {
        case .firstButName:
            //performSegue(withIdentifier: "goToSearchByWord", sender: nil)
            break
        case .secondButName:
            break
        case .thirdButName:
            break
        case .fourthButName:
            break
        }
        
        
        
        
        //        let sb = UIStoryboard(name: "Main", bundle: nil)
        //        let item = buttonNamed[indexPath.row]
        //        switch item {
        //        case .firstButName:
        //            guard let vc = sb.instantiateViewController(withIdentifier: "SearchByWordsVC") as? SearchByWordsVC else { return }
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        case .secondButName:
        //            break
        //        case .thirdButName:
        //            break
        //        case .fourthButName:
        //            break
        
    }
   
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FirstCVCell
        return cell
    }
}
    
    
    



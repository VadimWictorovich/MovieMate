//
//  FirstCollectionInTVC.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 26.11.23.
//

import UIKit
import Alamofire
import AlamofireImage



final class BestMoviesInYearTVCell: UITableViewCell {
    
    private var collectionView: UICollectionView!
    private var moviesId: [MovieId] = []
    private var movies: [MovieDetail] = []
    weak var delegate: PushToVC?

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: contentView.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .darkGray

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell1")
        contentView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        getId()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       }
}

extension BestMoviesInYearTVCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as? BestMoviesInYearCVCell else { return UICollectionViewCell() }
        let movie = movies[indexPath.row]
        cell.backgroundColor = .black
        cell.layer.cornerRadius = 10
        cell.label.text = movie.name ?? "Название фильма"
        cell.label.textColor = .white
        DispatchQueue.main.async {
            guard let urlString = movie.poster?.previewUrl, let url = URL(string: urlString) else {
                print ("в методе cellForItemAtIndexPath класса BestMoviesInYearTVCell не получена urlImage")
                return
            }
            NetworkService.fetchMovieImage(imageURL: url) { result, error in
                if let error {
                    print("в методе cellForItemAtIndexPath класса BestMoviesInYearTVCell получена ошибка: \(error)")
                } else if let result {
                    DispatchQueue.main.async {
                        cell.imageView.image = result
                        cell.setNeedsLayout()
                    }
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.openVC(at: indexPath, identifier: "DetailVC")
    }
    
    private func getId() {
        NetworkService.fetchMovie2023 { [weak self] result,error in
            if let error {
                print("====в методе getMovieId класса BestMoviesInYearTVCell получена ошибка: \(error)")
            } else if let result {
//                print("====в методе getMovieId класса BestMoviesInYearTVCell получен result: \(result)")
                self?.moviesId = result.docs
                self?.collectionView.reloadData()
                self?.getMovie()
            }
        }
    }
    
    private func getMovie() {
        
        moviesId.forEach { value in
            NetworkService.fetchMovieById(movieId: value.id) { [weak self] result, error in
                if let error {
                    print("=====в методе getMovie класса BestMoviesInYearTVCell получена ошибка: \(error)")
                } else if let result {
//                    print("=====в методе getMovie класса BestMoviesInYearTVCell получен result: \(result)")
                    self?.movies.append(result)
                    self?.collectionView.reloadData()
                }
            }
        }
    }
}


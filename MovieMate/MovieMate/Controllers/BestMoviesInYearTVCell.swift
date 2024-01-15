//
//  FirstCollectionInTVC.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 26.11.23.
//

import UIKit

protocol PushToVC: AnyObject {
    func didSelectCell(at indexPath: IndexPath)
}

final class BestMoviesInYearTVCell: UITableViewCell {
    
    private var collectionView: UICollectionView!
    weak var delegate: PushToVC?
    var moviesId: [MovieId] = []
    var movies: [MovieDetail] = []
    
    
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
        getMovie()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       }
}

extension BestMoviesInYearTVCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviesId.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as? BestMoviesInYearCVCell,
              movies.isEmpty else { return UICollectionViewCell() }
        print("moviesId------------\(moviesId.count)")
        print("movies------------\(movies.count)")
//        let movie = movies[indexPath.row]
        cell.backgroundColor = .black
        cell.layer.cornerRadius = 10
        cell.imageView.image = UIImage(named: "изображение по умолчанию")
        cell.label.text = "Название фильма"
        cell.label.textColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 150, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCell(at: indexPath)
    }
    
    private func getMovieId() {
        NetworkService.fetchMovie2023 { [weak self] result, _ in
            guard let result else { return }
            self?.moviesId = result.docs
            self?.collectionView.reloadData()
            }
        }
    
    private func getMovie() {
        getMovieId()
        moviesId.forEach { value in
            NetworkService.fetchMovieById(movieId: value.id) { [weak self] result, _ in
                guard let result else { return }
                self?.movies.append(result)
            }
        }
    }
}


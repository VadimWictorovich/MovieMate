//
//  AllTimeTVCell.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 28.11.23.
//

import UIKit

final class AllTimeTVCell: UITableViewCell {
   
    private var collectionView: UICollectionView!
    private var moviesId: [MovieId] = []
    private var movies: [MovieDetail] = []
    weak var delegate: DelegateGoToMovieDetail?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: contentView.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .darkGray

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "AllTimeCVCell", bundle: nil), forCellWithReuseIdentifier: "Cell2")
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

extension AllTimeTVCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as? AllTimeCVCell else { return UICollectionViewCell() }
        let movie = movies[indexPath.row]
        cell.backgroundColor = .black
        cell.layer.cornerRadius = 10
        cell.label.text = movie.name ?? "Название фильма"
        cell.label.textColor = .white
        DispatchQueue.main.async {
            guard let urlString = movie.poster?.previewUrl, let url = URL(string: urlString) else {
                print ("в методе cellForItemAtIndexPath класса AllTimeTVCell не получена urlImage")
                return
            }
            NetworkService.fetchMovieImage(imageURL: url) { result, error in
                if let error {
                    print("в методе cellForItemAtIndexPath класса AllTimeTVCell получена ошибка: \(error)")
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
        let movie = movies[indexPath.row]
        delegate?.openVCMovieDetail(at: indexPath, detail: movie, movieId: nil)
    }
    
    private func getId() {
        NetworkService.fetchBestMovieOfAllTime { [weak self] result, error in
            if let error {
                print("====в методе getMovieId класса AllTimeTVCell получена ошибка: \(error)")
            } else if let result {
//                print("====в методе getMovieId класса AllTimeTVCell получен result: \(result)")
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
                    print("=====в методе getMovie класса AllTimeTVCell получена ошибка: \(error)")
                } else if let result {
//                    print("=====в методе getMovie класса AllTimeTVCell получен result: \(result)")
                    self?.movies.append(result)
                    self?.collectionView.reloadData()
                }
            }
        }
    }
}

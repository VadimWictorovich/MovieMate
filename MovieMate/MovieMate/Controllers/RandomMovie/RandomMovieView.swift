//
//  RandomMovieView.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 11.01.24.
//

import UIKit


final class RandomMovieView: UIView {
    
        weak var delegate: DelegateGoToMovieDetail?
        weak var delegateClosed: DelegateClosedView?
        var movie: MovieDetail?
    
            
        private let nameMovieLabel: UILabel = {
            let lab = UILabel()
            lab.font = .systemFont(ofSize: 10)
            lab.textColor = .black
            lab.textAlignment = .center
            lab.numberOfLines = 0
            lab.translatesAutoresizingMaskIntoConstraints = false
//            lab.text = "имя фильма"
            return lab
        }()
    

        private let textLabel: UILabel = {
            let label = UILabel()
            label.text = "Вам представлен случайный фильм"
            label.font = .systemFont(ofSize: 15)
            label.textColor = .black
            label.textAlignment = .center
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    
        private let closeButton: UIButton = {
            let but = UIButton()
            but.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            but.contentMode = .scaleAspectFill
            but.addTarget(nil, action: #selector(HomeTVController.closeRandomMovieView), for: .touchUpInside)
            but.translatesAutoresizingMaskIntoConstraints = false
            return but
        }()
        
        
        private let reapitButton: UIButton = {
            let but = UIButton()
            but.setTitle("Повторить!", for: .normal)
            but.setTitleColor(.white, for: .normal)
            but.backgroundColor = #colorLiteral(red: 0.2274968624, green: 0.8351719975, blue: 0.7646718621, alpha: 1)
            but.layer.cornerRadius = 20
            but.addTarget(nil, action: #selector(HomeTVController.showRandomMovie), for: .touchUpInside)
            but.translatesAutoresizingMaskIntoConstraints = false
            return but
        }()
    
        
        private lazy var picture: UIImageView = {
            let picture = UIImageView()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openDetailVC))
            picture.contentMode = .scaleAspectFill
            picture.addGestureRecognizer(tapGesture)
            picture.isUserInteractionEnabled = true
            picture.translatesAutoresizingMaskIntoConstraints = false
            return picture
        }()
    
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
            setupConstrains()
        }

        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        private func configure() {
            backgroundColor = #colorLiteral(red: 0.9999310374, green: 0.9999989867, blue: 0.7902810574, alpha: 1)
            layer.cornerRadius = 15
            layer.borderWidth = 5.0
            layer.borderColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            
            addSubview(textLabel)
            addSubview(nameMovieLabel)
            addSubview(closeButton)
            addSubview(reapitButton)
            addSubview(picture)
        }
        
        
        private func setupConstrains() {
            NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 5.0).isActive = true
            NSLayoutConstraint(item: closeButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -5.0).isActive = true
            NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0).isActive = true
            NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0).isActive = true
            
            NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 30.0).isActive = true
            NSLayoutConstraint(item: textLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 6.0).isActive = true
            NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 6.0).isActive = true
            
            NSLayoutConstraint(item: picture, attribute: .top, relatedBy: .equal, toItem: textLabel, attribute: .topMargin, multiplier: 1.0, constant: 100.0).isActive = true
            NSLayoutConstraint(item: picture, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 280.0).isActive = true
            NSLayoutConstraint(item: picture, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 280.0).isActive = true
            NSLayoutConstraint(item: picture, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerXWithinMargins, multiplier: 1.0, constant: 0.0).isActive = true
            
            NSLayoutConstraint(item: nameMovieLabel, attribute: .bottom, relatedBy: .equal, toItem: picture, attribute: .bottomMargin, multiplier: 1.0, constant: 100.0).isActive = true
            NSLayoutConstraint(item: nameMovieLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 6.0).isActive = true
            NSLayoutConstraint(item: nameMovieLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 6.0).isActive = true
            
            NSLayoutConstraint(item: reapitButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -30.0).isActive = true
            NSLayoutConstraint(item: reapitButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 30.0).isActive = true
            NSLayoutConstraint(item: reapitButton, attribute: .top, relatedBy: .equal, toItem: nameMovieLabel, attribute: .topMargin, multiplier: 1.0, constant: 30.0).isActive = true
        }
    
    
     func updateUIWithMovie() {
         guard let movie else {
            print("Ошибка в методе updateUIWithMovie: объект фильма не инициализирован")
            return
         }
         print("Обновление UI с информацией о фильме: \(movie.name ?? "No value")")
         DispatchQueue.main.async { [weak self] in
            self?.nameMovieLabel.text = "\(movie.name ?? "No value"). '\(movie.year?.description ?? " ")'"
            guard let imageUrlString = movie.poster?.previewUrl,
                  let imageURL = URL(string: imageUrlString) else { return }
            NetworkService.fetchMovieImage(imageURL: imageURL) { result, error in
            if let error {
                print("возникла ошибка в методе updateUIWithMovie при получении изображения: \(error)")
                return
            }
                guard let result else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.picture.image = result

                }
            }
        }
    }
    
    @objc func openDetailVC() {
        guard let movie else { return }
        delegateClosed?.closedView()
        delegate?.openVCMovieDetail(at: nil, detail: movie, movieId: nil)
    }
}


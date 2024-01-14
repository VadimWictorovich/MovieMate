//
//  SeatchByWordsView.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 6.01.24.
//

import UIKit

final class SeatchByWordsView: UIView {

    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите ключевое слово, по которому будет осуществлен поиск"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Введите слово"
        tf.textColor = .black
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 10
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    private let closeButton: UIButton = {
        let but = UIButton()
        but.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        but.contentMode = .scaleAspectFill
        but.addTarget(nil, action: #selector(HomeTVController.closeSearchView), for: .touchUpInside)
        but.translatesAutoresizingMaskIntoConstraints = false
        return but
    }()
    
    
    private let seatchButton: UIButton = {
        let but = UIButton()
        but.setTitle("Искать", for: .normal)
        but.setTitleColor(.white, for: .normal)
        but.backgroundColor = #colorLiteral(red: 0.2274968624, green: 0.8351719975, blue: 0.7646718621, alpha: 1)
        but.layer.cornerRadius = 20
        but.addTarget(nil, action: #selector(seatchMovieAction), for: .touchUpInside)
        but.translatesAutoresizingMaskIntoConstraints = false
        return but
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
        addSubview(textField)
        addSubview(closeButton)
        addSubview(seatchButton)
    }
    
    
    private func setupConstrains() {
        NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 5.0).isActive = true
        NSLayoutConstraint(item: closeButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -5.0).isActive = true
        NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0).isActive = true
        NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0).isActive = true
        
        NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 50.0).isActive = true
        NSLayoutConstraint(item: textLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 6.0).isActive = true
        NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 6.0).isActive = true
        
        NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: textLabel, attribute: .topMargin, multiplier: 1.0, constant: 70.0).isActive = true
        NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -10.0).isActive = true
        NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0).isActive = true
        
        NSLayoutConstraint(item: seatchButton, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .topMargin, multiplier: 1.0, constant: 50.0).isActive = true
        NSLayoutConstraint(item: seatchButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -30.0).isActive = true
        NSLayoutConstraint(item: seatchButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 30.0).isActive = true
    }
    
    
    @objc private func seatchMovieAction() {
        
    }
    

}

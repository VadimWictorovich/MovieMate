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
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Введите слово"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    private let closeButton: UIButton = {
        let but = UIButton()
        but.imageView?.image = UIImage(systemName: "xmark.circle.fill")
        but.addTarget(nil, action: #selector(HomeTVController.closeSearchView), for: .touchUpInside)
        but.translatesAutoresizingMaskIntoConstraints = false
        return but
    }()
    
    
    private let seatchButton: UIButton = {
        let but = UIButton()
        but.titleLabel?.text = "Искать!"
        but.titleLabel?.textColor = .black
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
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.borderWidth = 5.0
        layer.borderColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        addSubview(textLabel)
        addSubview(textField)
        addSubview(closeButton)
        addSubview(seatchButton)
    }
    
    
    private func setupConstrains() {
        
    }
    
    
    @objc private func seatchMovieAction() {
        
    }
    

}

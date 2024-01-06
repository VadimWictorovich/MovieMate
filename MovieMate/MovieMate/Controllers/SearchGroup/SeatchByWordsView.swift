//
//  SeatchByWordsView.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 6.01.24.
//

import UIKit

class SeatchByWordsView: UIView {

    private let textLabek: UILabel = {
        let label = UILabel()
        label.text = "Введите ключевое слово, по которому будет осуществлен поиск"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Введите слово"
        return tf
    }()
    
    private let cancelButton: UIButton = {
        let but = UIButton()
        
        
        return but
    }()
    

}

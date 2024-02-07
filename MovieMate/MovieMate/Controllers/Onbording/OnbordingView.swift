//
//  OnbordingView.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 7.02.24.
//

import UIKit


class OnbordingView: UIView {
    
    weak var delegateClosed: ClosedOnbording?
    
    private let pageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonHome: UIButton = {
        let but = UIButton()
        but.setTitle("Начать", for: .normal)
        but.setTitleColor(.white, for: .normal)
//        but.backgroundColor = .white
        but.layer.cornerRadius = 10
        but.layer.borderWidth = 1.0
        but.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        but.addTarget(nil, action: #selector(goToHomeVC), for: .touchUpInside)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.isHidden = true
        return but
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pageLabel)
        addSubview(buttonHome)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPageLabelText(text: String) {
        pageLabel.text = text
    }
    
    public func setPagelabelTransform(transform: CGAffineTransform) {
        pageLabel.transform = transform
    }
    
    public func noHideButton() {
        buttonHome.isHidden = false
    }
    
    public func fixText() {
        pageLabel.font = .boldSystemFont(ofSize: 14)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            pageLabel.leadingAnchor.constraint (equalTo: leadingAnchor, constant: 30),
            pageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            pageLabel.centerYAnchor.constraint (equalTo: centerYAnchor),
            pageLabel.heightAnchor.constraint (equalToConstant: 200),
            
            buttonHome.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonHome.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            buttonHome.widthAnchor.constraint(equalToConstant: 100),
//            buttonHome.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
    
    @objc private func goToHomeVC() {
        delegateClosed?.closeOnbord()
    }
    
}

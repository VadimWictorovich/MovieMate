//
//  ViewControllersExtention.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 18.01.24.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

extension UIViewController: NVActivityIndicatorViewable {
    func startActivityAnimation() {
        startAnimating(message: "Загрузка...", type: .ballRotateChase, color: .white, textColor: .white)
    }
    
    func stopActivityAnimation() {
        stopAnimating()
    }
}



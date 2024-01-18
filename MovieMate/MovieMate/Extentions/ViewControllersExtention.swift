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
    func startActivityAnimation(message: String, type: NVActivityIndicatorType, color: UIColor, textColor: UIColor) {
        startAnimating(message: message, type: type, color: color, textColor: textColor)
    }
    
    func stopActivityAnimation() {
        stopAnimating()
    }
}

//
//  Protocols.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 22.01.24.
//

import UIKit


protocol PushToVC: AnyObject {
    func openVC(at indexPath: IndexPath?, identifier: String)
}

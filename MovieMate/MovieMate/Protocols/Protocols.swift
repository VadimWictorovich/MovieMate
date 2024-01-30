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

protocol DelegateGoToListMovieDetail: AnyObject {
    func openTVCListMovies(list: [MovieDetail])
}

protocol DelegateGoToMovieDetail: AnyObject {
    func openVCMovieDetail(at indexPath: IndexPath?, detail: MovieDetail?, movieId: Int?)
}



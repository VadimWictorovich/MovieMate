//
//  ModelRating.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 11.12.23.
//

import Foundation

struct Rating {
    let kp: Double?
    let imdb: Double?
    let tmdb: Double?
    let filmCritics: Double? // pейтинг кинокритиков
    let russianFilmCritics: Double? // Рейтинг кинокритиков из РФ
    let await: Double? // Рейтинг основанный на ожиданиях пользователей
}

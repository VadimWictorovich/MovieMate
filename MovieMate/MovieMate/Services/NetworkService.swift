//
//  NetworkService.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 11.12.23.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON


class NetworkService {
    
    static func fetchMovie2023(callback: @escaping (_ result: MovieIdsResponse?, _ error: Error?) -> ()) {
        let url = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=1&selectFields=id&notNullFields=&type=movie&typeNumber=1&year=2023"
        let header: HTTPHeaders = ["X-API-KEY": ModelAPIConstans.apiKey]
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .response { response in
                var value: MovieIdsResponse?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data else { callback (value, err)
                        return }
//                    print("у метода fetchMovie2023 класса NetworkService получена data \(JSON(data))")
                    do {
                        value = try JSONDecoder().decode(MovieIdsResponse.self, from: data)
                    } catch (let decodError) {
                        print("в методе fetchMovie2023 класса NetworkService при декодировании получена ошибка:\(decodError)")
                    }
                case .failure(let error):
                    err = error
                }
                callback(value, err)
            }
    }
    
    
    static func fetchBestMovieOfAllTime(callback: @escaping (_ result: MovieIdsResponse?, _ error: Error?) -> ()) {
        let url = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=1&selectFields=id&notNullFields&type=movie&lists=top250"
        let header: HTTPHeaders = ["X-API-KEY": ModelAPIConstans.apiKey]
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .response { response in
                var value: MovieIdsResponse?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data else { callback (value, err)
                        return }
//                    print("у метода fetchBestMovieOfAllTime класса NetworkService получена data \(JSON(data))")
                    do {
                        value = try JSONDecoder().decode(MovieIdsResponse.self, from: data)
                    } catch (let decodError) {
                        print("в методе fetchBestMovieOfAllTime класса NetworkService при декодировании получена ошибка:\(decodError)")
                    }
                case .failure(let error):
                    err = error
                }
                callback(value, err)
            }
    }
    
    
    static func fetchGenresList(callback: @escaping (_ result: [Genre]?, _ error: Error?) -> ()) {
        let url = "https://api.kinopoisk.dev/v1/movie/possible-values-by-field?field=genres.name"
        let header: HTTPHeaders = ["X-API-KEY": ModelAPIConstans.apiKey]
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .response { response in
                var value: [Genre]?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data else {
                        callback (value, err)
                        return
                    }
//                    print("у метода fetchGenresList класса NetworkService получена data \(JSON(data))")
                    do {
                        value = try JSONDecoder().decode([Genre].self, from: data)
                    } catch (let decodError) {
                        print("в методе fetchGenresList класса NetworkService при декодировании получена ошибка:\(decodError)")
                    }
                case .failure(let error):
                    err = error
                }
                callback(value, err)
            }
    }
    
    
    
    static func fetchMovieById (movieId: Int, callback: @escaping (_ result: MovieDetail?, _ error: Error?) -> ()) {
        let url = "https://api.kinopoisk.dev/v1.4/movie/\(String(movieId))"
        let header: HTTPHeaders = ["X-API-KEY": ModelAPIConstans.apiKey]
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .response { response in
                var movie: MovieDetail?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data else {
                        callback(movie, err)
                        return }
//                    print("у метода fetchMovieById класса NetworkService получена data \(JSON(data))")
                    do {
                        movie = try JSONDecoder().decode(MovieDetail.self, from: data)
                    } catch (let decodError) {
                        print("у метода fetchMovieById класса NetworkService при декаодировании получена ошибка \(decodError)")
                    }
                case .failure(let error):
                    err = error
                }
                callback(movie, err)
            }
    }
    
    
    // MARK: - Search random movie
    static func fetchRandomMovie (callback: @escaping (_ result: MovieDetail?, _ error: Error?) -> ()) {
        let url = "https://api.kinopoisk.dev/v1.4/movie/random?notNullFields=id&type=movie&lists=top250"
        let header: HTTPHeaders = ["X-API-KEY": ModelAPIConstans.apiKey]
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .response { response in
                var movie: MovieDetail?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data else {
                        callback(movie, err)
                        return
                    }
//                    print(JSON(data))
                    do {
                        movie = try JSONDecoder().decode(MovieDetail.self, from: data)
                    } catch (let decodError) {
//                        print("Error decoding response data: \(decodError)")
                    }
                case .failure(let error):
                    err = error
                }
                callback(movie, err)
            }
    }
    
    
    // MARK: - Fetch image movie
    static func fetchMovieImage (imageURL: URL, callback: @escaping (_ result: UIImage?, _ error: Error?) -> ()) {
        AF.request(imageURL).responseImage { response in
            switch response.result {
            case .success(let image):
                callback(image, nil)
            case .failure(let error):
                callback(nil, error)
            }
        }
    }
    
    
    // MARK: - Search movie by word
    static func fetchMovieByWord (words: String, callback: @escaping (_ result: MovieByWord?, _ error: Error?) -> ()) {
        let url = "https://api.kinopoisk.dev/v1.4/movie/search?page=1&limit=5&query=\(words)"
        let header: HTTPHeaders = ["X-API-KEY": ModelAPIConstans.apiKey]
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .response { response in
                var movieIdResp: MovieByWord?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data else {
                        callback(movieIdResp, err)
                        return }
                    print("у метода fetchMovieByWord получена data \(JSON(data))")
                    do {
                        movieIdResp = try JSONDecoder().decode(MovieByWord.self, from: data)
                    } catch (let decodError) {
                        print("у метода fetchMovieByWord получен decodError--------------------\(decodError)")
                    }
                case .failure(let error):
                    err = error
                }
                callback(movieIdResp, err)
            }
    }
    
    
    static func fetchMovieByGenresName (genresName: String, callback: @escaping (_ result: MovieByWord?, _ error: Error?) -> ()) {
        let url = "https://api.kinopoisk.dev/v1.4/movie/search?page=1&limit=5&query=\(genresName)"
        let header: HTTPHeaders = ["X-API-KEY": ModelAPIConstans.apiKey]
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .response { response in
                var movieList: MovieByWord?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data else {
                        callback(movieList, err)
                        return }
                    print("у метода fetchMovieByWord получена data \(JSON(data))")
                    do {
                        movieList = try JSONDecoder().decode(MovieByWord.self, from: data)
                    } catch (let decodError) {
                        print("у метода fetchMovieByWord получен decodError--------------------\(decodError)")
                    }
                case .failure(let error):
                    err = error
                }
                callback(movieList, err)
            }
    }
    
    
    // не работает
    static func fetchMoviePrimere (callback: @escaping (_ result: MovieByWord?, _ error: Error?) -> ()) {
        let url = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=8&premiere.world=01.10.2023-31.01.2024"
        let header: HTTPHeaders = ["X-API-KEY": ModelAPIConstans.apiKey]
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .response { response in
                var movieList: MovieByWord?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data else {
                        callback(movieList, err)
                        return }
                    print("у метода fetchMoviePrimere получена data \(JSON(data))")
                    do {
                        movieList = try JSONDecoder().decode(MovieByWord.self, from: data)
                    } catch (let decodError) {
                        print("у метода fetchMoviePrimere получен decodError--------------------\(decodError)")
                    }
                case .failure(let error):
                    err = error
                }
                callback(movieList, err)
            }
    }
}

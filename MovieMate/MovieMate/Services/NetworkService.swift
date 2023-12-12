//
//  NetworkService.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 11.12.23.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkService {
    
    static func fetchMovie2023(callback: @escaping (_ result: MovieIdsResponse?, _ error: Error?) -> ()) {
        let url = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=50&selectFields=id&notNullFields=&type=movie&typeNumber=1&year=2023"
        let header: HTTPHeaders = ["X-API-KEY": ModelAPIConstans.apiKey]
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .response { response in
                var value: MovieIdsResponse?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data else { callback (value, err)
                        return }
                    do {
                        value = try JSONDecoder().decode(MovieIdsResponse.self, from: data)
                    } catch (let decodError) {
                        print("decodError--------------------\(decodError)")
                    }
                case .failure(let error):
                    err = error
                }
                callback(value, err)
        }
    }
    
    static func fethMovieById (movieId: Int, callback: @escaping (_ result: MovieDetail?, _ error: Error?) -> ()) {
        let url = ModelAPIConstans.serverPath + String(movieId)
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
                    do {
                        movie = try JSONDecoder().decode(MovieDetail.self, from: data)
                    } catch (let decodError) {
                        print("decodError--------------------\(decodError)")
                    }
                case .failure(let error):
                    err = error
                }
                callback(movie, err)
        }
    }
}

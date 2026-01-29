//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 22.01.26.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private let monitor = NetworkReachabilityManager()
    
    private let apiKey = "76323a01e753cd71bd2ef9521474d682"
    private let baseUrl = "https://api.themoviedb.org/3"
    
    var isConnected: Bool {
        return monitor?.isReachable ??  false
    }
    
    func startMonitoring(onStatusChange: @escaping(Bool) -> Void) {
        monitor?.startListening(onUpdatePerforming: { status in
            switch status {
            case .reachable, .unknown:
                onStatusChange(true)
            case .notReachable:
                onStatusChange(false)
            }
        })
    }
    
    
//    func getTrendingMovies (completion: @escaping (Result<[Movie], Error>) -> Void) {
//        guard let url = URL(string: "\(baseUrl)/trendings/movie/day?api_key=\(apiKey)") else { return }
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, _, error in
//            if let error {
//                print(error.localizedDescription)
//            } else if let data {
//                do {
//                    let result = try JSONDecoder().decode(MovieResponse.self, from: data)
//                    if(result.success == false) {
//                        print(result.statusMessage)
//                    } else {
//                        completion(.success(result.results!))
//                    }
//                } catch {
//                    print(error)
//                    completion(.failure(error))
//                }
//            }
//        }.resume()
//    }
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>)-> Void) {
        let url = "\(baseUrl)/trending/movie/day"
        let parameters: [String: Any] = ["api_key": apiKey]
        
        AF.request(url, method: .get, parameters: parameters)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                        
                        if movieResponse.success == false {
                            print(movieResponse.statusMessage)
                        } else {
                            completion(.success(movieResponse.results ?? []))
                        }
                    } catch {
                        print(error)
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
    
//    func getUserData() {
//        AF.request("\(baseURL)/users").responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    self.user = try JSONDecoder().decode([User].self, from: data)
//                    self.completion?()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    
    func searchMovie(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        let searchURL = "\(baseUrl)/search/movie?api_key=\(apiKey)&query=\(query)"
        guard let url = URL(string: searchURL) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                print(error.localizedDescription)
            } else if let data {
                do {
                    let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                    if(result.success == false) {
                        print(result.statusMessage)
                    } else {
                        completion(.success(result.results!))
                    }
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

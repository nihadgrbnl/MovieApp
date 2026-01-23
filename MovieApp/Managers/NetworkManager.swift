//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 22.01.26.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let apiKey = "76323a01e753cd71bd2ef9521474d682"
    private let baseUrl = "https://api.themoviedb.org/3"
    
    
    func getTrendingMovies (completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)/trending/movie/day?api_key=\(apiKey)") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                print(error.localizedDescription)
            } else if let data {
                
                
                do {
                    let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                    
                                        
                    if(result.success == false) {
                        print(result.status_message)
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
                        print(result.status_message)
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

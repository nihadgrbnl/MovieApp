//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 09.01.26.
//

import Foundation

struct HomeModel {
    let title: String
    let items : [NewMovieResult]
}

class HomeViewModel {
    
    var items = [HomeModel]()
    let manager = NetworkManager()
    
    var success : (() -> Void)?
    var error: ((String) -> Void)?
    
    var onShowUpdateToast: (() -> Void)?
    
    func getMovies() {
        getNowPlayingMovies()
        getPopularMovies()
        getUpcomingMovies()
        getTopRatedMovies()
    }
    
    private func getNowPlayingMovies() {
        manager.request(model: NewMovieModel.self,
                        endpoint: "movie/now_playing") { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.items.append(.init(title: "Now Playing",
                                        items: data.results ?? []))
                self.success?()
            }
        }
    }
    
    private func getPopularMovies() {
        manager.request(model: NewMovieModel.self,
                        endpoint: "movie/popular") { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.items.append(.init(title: "Popular",
                                        items: data.results ?? []))
                self.success?()
            }
        }
    }
    
    private func getTopRatedMovies() {
        manager.request(model: NewMovieModel.self,
                        endpoint: "movie/top_rated") { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.items.append(.init(title: "Top Rated",
                                        items: data.results ?? []))
                self.success?()
                
            }
        }
    }
    
    private func getUpcomingMovies() {
        manager.request(model: NewMovieModel.self,
                        endpoint: "movie/upcoming") { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.items.append(.init(title: "Upcoming",
                                        items: data.results ?? []))
                self.success?()
            }
        }
    }
    
    
    //    private func loadLocalData() {
    //        DataPersistenceManager.shared.fetchingMoviesFromDatabase{ [weak self] result in
    //            switch result {
    //            case .success(let movieItems):
    //                guard !movieItems.isEmpty else { return }
    //                print("Local database'den \(movieItems.count) film yuklendi")
    //
    //                self?.movies = movieItems.map{ $0.toMovieStruct() }
    ////                self?.processMovies()
    //                self?.onDataUpdated?()
    //
    //            case .failure(let error):
    //                print("Local data hatasi: \(error.localizedDescription)")
    //            }
    //        }
    //    }
    
    //    func fetchData() {
    //
    //        guard NetworkManager.shared.isConnected else {
    //            print("⚠️ İnternet yok, istek atılmadı.")
    //            self.onError?("No Internet Connection")
    //            loadLocalData()
    //            return
    //        }
    //
    //        NetworkManager.shared.getTrendingMovies { [weak self] result in
    //            guard let self = self else { return }
    //
    //            switch result{
    //            case .success(let newMovies):
    //                print("\(newMovies.count) films came from API, Database'ye yaziliyor")
    //                self.saveToDatabase(movies: newMovies)
    //
    //
    //                loadLocalData()
    //
    //                if !newMovies.isEmpty{
    //                    self.onShowUpdateToast?()
    //                }
    //
    //            case .failure(let error):
    //                print(error.localizedDescription)
    //            }
    //        }
    //    }
    
    //    func userPressedRefreshBtn() {
    //        print("Kullanici yenileme istedi. Local yeniden yukleniyor.")
    //        loadLocalData()
    //    }
    
    //    private func saveToDatabase(movies: [Movie]) {
    //        for movie in movies {
    //            DataPersistenceManager.shared.loadLocalData(model: movie) { _ in
    //            }
    //        }
    //    }
    
    //    private func processMovies() {
    //        self.trendingMovies = Array(movies.prefix(10))
    //        self.gridMovies = movies
    //    }
    
    //    func selectedCategory(at index : Int) {
    //        self.selectedCategoryIndex = index
    //        let selectedTitle = categories[index]
    //
    //        if selectedTitle == "All" {
    //            gridMovies = movies
    //        } else {
    //            gridMovies = movies
    //        }
    //        onDataUpdated?()
    //    }
    
    //    func getMovie(at index: Int) -> Movie {
    //        if index < self.gridMovies.count {
    //            return self.gridMovies[index]
    //        }
    //        return self.gridMovies[0]
    //    }
}



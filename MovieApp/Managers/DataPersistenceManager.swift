//
//  DataPersistenceManager.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 27.01.26.
//

import Foundation
import CoreData
import UIKit

class DataPersistenceManager {
    
    static let shared = DataPersistenceManager()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
    func loadLocalData(model: Movie, completion: @escaping (Result<Void, Error>) -> Void) {
        
        context.perform{ [weak self] in
            guard let self = self else { return }
        }
        
        if self.checkItemExist(id: model.id) {
            print("Bu film zaten veritabaninda var: \(model.title ?? "")")
            completion(.success(()))
            return
        }
        
        model.toMovieItem(in: self.context)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            print("Veritabanina kayit hatasi : \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    func fetchingMoviesFromDatabase(completion: @escaping (Result<[MovieItem], Error>) -> Void) {
        
        let request: NSFetchRequest<MovieItem> = MovieItem.fetchRequest()
        
        do {
            let movies = try context.fetch(request)
            completion(.success(movies))
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteMovieWith(model: MovieItem, completion: @escaping (Result<Void, Error>) -> Void) {
        
        context.delete(model)
        
        do{
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    private func checkItemExist(id: Int) -> Bool {
        let fetchRequest: NSFetchRequest<MovieItem> = MovieItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do{
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            return false
        }
    }
    
    func removeDuplicateMovies() {
            let request: NSFetchRequest<MovieItem> = MovieItem.fetchRequest()
            
            do {
                let allMovies = try context.fetch(request)

                let groupedMovies = Dictionary(grouping: allMovies, by: { $0.id })
                
                for (_, movies) in groupedMovies {
                    if movies.count > 1 {
                        for duplicate in movies.dropFirst() {
                            context.delete(duplicate)
                        }
                    }
                }
                
                try context.save()
                print("Çift kayıtlar silindi.")
                
            } catch {
                print("Temizlik hatası: \(error.localizedDescription)")
            }
        }
}

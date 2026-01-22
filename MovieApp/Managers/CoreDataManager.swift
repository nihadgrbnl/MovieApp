////
////  CoreDataManager.swift
////  MovieApp
////
////  Created by Nihad Gurbanli on 15.01.26.
////
//
//import Foundation
//import UIKit
//import CoreData
//
//class CoreDataManager {
//    
//    static let shared = CoreDataManager()
//    
//    let container: NSPersistentContainer
//    let context: NSManagedObjectContext
//    
//    private init() {
//        
//        container = NSPersistentContainer(name: "MovieApp")
//        
//        container.loadPersistentStores {description, error in
//            if let error = error {
//                print("Error. CoreData could not load \(error.localizedDescription)")
//            }
//        }
//        context = container.viewContext
//    }
//    
//    func saveMovie(movie: MovieModel) {
//        let entity = MovieEntity(context: context)
//        
//        entity.id = movie.id
//        entity.title = movie.title
//        entity.posterImage = movie.posterImage
//        entity.rating = movie.rating ?? 0
//        entity.releaseDate = Int64(movie.releaseDate ?? 0)
//        entity.runtime = Int64(movie.runtime ?? 0)
//        entity.genre = movie.genre?.joined(separator: ",")
//        entity.backdrop = movie.backdropImage
//        entity.overview = movie.overview
//        
//        saveContext()
//        print("saved: \(movie.title)")
//    }
//    
//    func deleteMovie (movieID: String) {
//        let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
//        fetchRequest.predicate = NSPredicate(format: "id == %@", movieID)
//        
//        do {
//            let results = try context.fetch(fetchRequest)
//            
//            if let filmToDelete = results.first {
//                context.delete(filmToDelete)
//                saveContext()
//                print("deleted: \(movieID)")
//            }
//        } catch {
//            print("delete error \(error.localizedDescription)")
//        }
//    }
//    
//    func fetchAllMovies() -> [MovieModel] {
//        let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
//        
//        do{
//            let entitites = try context.fetch(fetchRequest)
//            
//            var movieModels: [MovieModel] = []
//            
//            for entity in entitites {
//                let model = MovieModel(id: entity.id,
//                                       title: entity.title,
//                                       overview: entity.overview,
//                                       posterImage: entity.posterImage,
//                                       backdropImage: entity.backdrop,
//                                       rating: entity.rating,
//                                       releaseDate: Int(entity.releaseDate),
//                                       genre: entity.genre?.components(separatedBy: ",") ?? [],
//                                       viewCount: 0,
//                                       director: "",
//                                       runtime: Int(entity.runtime)
//                )
//                movieModels.append(model)
//            }
//            return movieModels
//        } catch {
//            print("fetch data error: \(error.localizedDescription)")
//            return []
//        }
//    }
//    
//    func isMovieSaved(movieID: String) -> Bool {
//        let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
//        fetchRequest.predicate = NSPredicate(format: "id == %@", movieID)
//        
//        do {
//            let count = try context.count(for: fetchRequest)
//            return count > 0
//        } catch {
//            return false
//        }
//    }
//    
//    private func saveContext() {
//        do {
//            try context.save()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    
//    
//    
//}

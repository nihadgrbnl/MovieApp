//
//  MovieItem+CoreDataProperties.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 28.01.26.
//
//

public import Foundation
public import CoreData


public typealias MovieItemCoreDataPropertiesSet = NSSet

extension MovieItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieItem> {
        return NSFetchRequest<MovieItem>(entityName: "MovieItem")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var vote_average: Double
    @NSManaged public var release_date: String?
    @NSManaged public var backdrop_path: String?

}

extension MovieItem : Identifiable {

}

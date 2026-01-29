//
//  MovieEntity+CoreDataProperties.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 15.01.26.
//
//

public import Foundation
public import CoreData


public typealias MovieEntityCoreDataPropertiesSet = NSSet

extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var posterImage: String?
    @NSManaged public var rating: Double
    @NSManaged public var releaseDate: Int64
    @NSManaged public var runtime: Int64
    @NSManaged public var genre: String?
    @NSManaged public var backdrop: String?
    @NSManaged public var overview: String?

}

extension MovieEntity : Identifiable {

}

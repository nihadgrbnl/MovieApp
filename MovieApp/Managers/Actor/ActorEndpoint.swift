//
//  ActorEndpoint.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 10.02.26.
//

import Foundation

enum ActorEndpoint: String {
    case popularActor = "person/popular"
}

enum ActorEndpoint2 {
    case popularActor(page: String)
    
    var path: String{
        switch self{
        case .popularActor(let page):
            return "person/popular?page=\(page)"
        }
    }
}

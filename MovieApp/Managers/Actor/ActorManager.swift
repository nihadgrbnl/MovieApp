//
//  ActorManager.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 10.02.26.
//

import Foundation

class ActorManager {
    private let manager = NetworkManager()
    
    func getPopularActorDatas(completion: @escaping((Actor?, String?) -> Void)) {
        manager.request(model: Actor.self,
                        endpoint: ActorEndpoint.popularActor.rawValue,
                        completion: completion)
    }
}

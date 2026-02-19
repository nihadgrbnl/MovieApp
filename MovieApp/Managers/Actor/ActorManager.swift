//
//  ActorManager.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 10.02.26.
//

import Foundation

class ActorManager : ActorUseCase{
    private let manager = NetworkManager()
    
    func getPopularActorDatas(page: String, completion: @escaping((Actor?, String?) -> Void)) {
        manager.request(model: Actor.self,
                        endpoint: ActorEndpoint2.popularActor(page: page).path,
                        completion: completion)
    }
}

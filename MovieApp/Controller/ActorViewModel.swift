//
//  ActorViewModel.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 10.02.26.
//

import Foundation

final class ActorViewModel {
    
    var items = [ActorResult]()
    
    var manager = ActorManager()
    
    var success: (() ->  Void)?
    var error: ((String) -> Void)?
    
    func getActorDatas() {
        manager.getPopularActorDatas { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.items = data.results ?? []
                self.success?()
            }
        }
        
    }
}

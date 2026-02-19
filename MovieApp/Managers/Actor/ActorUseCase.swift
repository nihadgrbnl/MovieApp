//
//  ActorUseCase.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 19.02.26.
//

import Foundation

protocol ActorUseCase {
    func getPopularActorDatas(page: String, completion: @escaping((Actor?, String?) -> Void))
}

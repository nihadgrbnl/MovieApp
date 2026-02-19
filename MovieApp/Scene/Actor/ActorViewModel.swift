//
//  ActorViewModel.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 10.02.26.
//

import Foundation

final class ActorViewModel {
    var actorData: Actor?
    var items = [ActorResult]()
    
    private var useCase: ActorUseCase
    
    var success: (() ->  Void)?
    var error: ((String) -> Void)?
    
    init(useCase: ActorUseCase) {
        self.useCase = useCase
    }
    
    func getActorDatas() {
        let page = "\((actorData?.page ?? 0) + 1)"
        print(page)
        useCase.getPopularActorDatas(page: page) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.actorData = data
                self.items.append(contentsOf: data.results ?? [])
                self.success?()
            }
        }
    }
    
    func startPagination(index: Int) {
        if index > items.count - 2 &&
            (actorData?.page ?? 0 <= actorData?.totalPages ?? 0) {
            getActorDatas()
        }
    }
}

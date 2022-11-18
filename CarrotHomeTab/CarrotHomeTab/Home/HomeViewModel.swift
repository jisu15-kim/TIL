//
//  HomeViewModel.swift
//  CarrotHomeTab
//
//  Created by 김지수 on 2022/11/19.
//

import Foundation
import Combine

final class HomeViewModel {
    let network: NetworkService
    @Published var items: [ItemInfo] = []
    
    let itemTapped = PassthroughSubject<ItemInfo, Never>()
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func fetch() {
//        let resource: Resource<ItemInfo> = Resource(base: <#T##String#>, path: <#T##String#>)
//        network.load(resource)
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: <#T##((Subscribers.Completion<Error>) -> Void)##((Subscribers.Completion<Error>) -> Void)##(Subscribers.Completion<Error>) -> Void#>, receiveValue: <#T##((ItemInfo) -> Void)##((ItemInfo) -> Void)##(ItemInfo) -> Void#>)
    }
}

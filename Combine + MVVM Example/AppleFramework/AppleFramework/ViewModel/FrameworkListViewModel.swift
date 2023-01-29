//
//  FrameworkListViewModel.swift
//  AppleFramework
//
//  Created by 김지수 on 2023/01/30.
//

import UIKit
import Combine

final class FrameworkListViewModel {
    
    // Combine
    
    // Data = Output
    let items: CurrentValueSubject<[AppleFramework], Never>
    let selectedItem: CurrentValueSubject<AppleFramework?, Never>
    // UserAction => Input
    let didSelect = PassthroughSubject<AppleFramework, Never>()
    
    init(items: [AppleFramework], selectedItem: AppleFramework? = nil) {
        self.items = CurrentValueSubject(items)
        self.selectedItem = CurrentValueSubject(selectedItem)
    }
    
    func didSelect(at indexPath: IndexPath) {
        let item = items.value[indexPath.row]
        selectedItem.send(item)
    }
}

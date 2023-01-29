//
//  FrameworkDetailViewModel.swift
//  AppleFramework
//
//  Created by 김지수 on 2023/01/30.
//

import Foundation
import Combine

final class FrameworkDetailViewModel {
    
    init(framework: AppleFramework) {
        self.framework = CurrentValueSubject(framework)
    }
    
    var framework: CurrentValueSubject<AppleFramework, Never>
    var buttonTapped = PassthroughSubject<AppleFramework, Never>()
    
    func learnMoreTapped() {
        buttonTapped.send(framework.value)
    }
}

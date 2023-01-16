//
//  TextView.swift
//  SwiftUI-Basic
//
//  Created by 김지수 on 2023/01/17.
//

import SwiftUI

struct TextView: View {
    var body: some View {
        Text("swiftUI")
            .font(.system(size: 30, weight: .bold, design: .default))
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}

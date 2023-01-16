//
//  ImageView.swift
//  SwiftUI-Basic
//
//  Created by 김지수 on 2023/01/17.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
        Image(systemName: "heart.fill")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}

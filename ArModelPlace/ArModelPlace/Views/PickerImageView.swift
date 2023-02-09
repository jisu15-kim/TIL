//
//  PickerImageView.swift
//  ArModelPlace
//
//  Created by 김지수 on 2023/02/09.
//

import SwiftUI

struct PickerImageView: View {
    var model: Image
    var body: some View {
            model
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .background(Color.white)
                .cornerRadius(20)
                .padding()
    }
}

struct PickerImageView_Previews: PreviewProvider {
    static var previews: some View {
        // 임의의 이미지
        PickerImageView(model: Image("chair_swan"))
    }
}

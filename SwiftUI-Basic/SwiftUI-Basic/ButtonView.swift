//
//  ButtonView.swift
//  SwiftUI-Basic
//
//  Created by 김지수 on 2023/01/17.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        Button {
            print("button clicked")
        } label: {
            Text("클릭해주세요")
                .font(.system(size: 20, weight: .bold, design: .default))
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: 200 ,height: 105.0)
        .background(.pink)
        .cornerRadius(30)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}

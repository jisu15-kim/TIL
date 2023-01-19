//
//  ContentView.swift
//  SwiftUI-Basic
//
//  Created by 김지수 on 2023/01/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            
            ImageView()
            ButtonView()
            TextView()
            
            HStack {
                ImageView()
                ButtonView()
                TextView()
            }
            
//            Spacer(minLength: 100)
            
            ZStack {
                ImageView()
                ButtonView()
                TextView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ConfigView.swift
//  Clima
//
//  Created by Marco Alonso Rodriguez on 25/04/23.
//

import SwiftUI

struct ConfigView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Hola")
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }.background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}

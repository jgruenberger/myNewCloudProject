//
//  ContentView.swift
//  myNewCloudProject
//
//  Created by JGRU on 6/21/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .imageScale(.large)
                .foregroundStyle(.green)
            Text("Welcome to my new App! New content to arrive soooooon!!!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

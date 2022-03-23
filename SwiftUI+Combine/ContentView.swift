//
//  ContentView.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 18/03/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        BreedScreenView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}

//
//  BreedListView.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import SwiftUI

struct BreedListView: View {
    
    @State private var searchString: String = ""
    let breeds: [Breed]
    
    var filteredBreeds: [Breed] {
        if searchString.count == 0 {
            return breeds
        } else {
            return breeds.filter { $0.name.contains(searchString) }
        }
    }
    
    var body: some View {
        NavigationView {
        List {
            ForEach(filteredBreeds) { breed in
                NavigationLink(destination: BreedDetailView(breed: breed)) {
                    BreedView(breed: breed)
                }
            }.listStyle(PlainListStyle())
        }
        .ignoresSafeArea()
        .navigationTitle("Find Your Perfect Cat")
        }
        .searchable(text: $searchString)
        .onAppear {
            URLCache.shared.memoryCapacity = 1024 * 1024 * 512
        }
    }
}

struct BreedListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedListView(breeds: [Breed.example1()])
    }
}

//
//  BreedView.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import SwiftUI

struct BreedScreenView: View {
    
    @StateObject private var breedFetcher = BreedFetcher()
    
    var body: some View {
        
        if breedFetcher.isLoading {
            TechStackLoadingView()
        } else if breedFetcher.error != nil {
            TechStackErrorView(errorMessage: breedFetcher.error?.localizedDescription ?? "")
        } else {
            BreedListView(breeds: breedFetcher.catBreeds)
        }
    }
}

struct BreedScreenView_Previews: PreviewProvider {
    static var previews: some View {
       BreedScreenView()
    }
}

//
//  BreedFetcher.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import Foundation
import Combine

final class BreedFetcher: TechStackService, ObservableObject {
    
    @Published var catBreeds: [Breed] = []
    @Published var filteredCats: [Breed] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    private(set) var cancellable: AnyCancellable?
    
    override init() {
        super.init()
        self.fetchBreeds()
    }
    
    private func filteredCats(_ breeds: String) -> [Breed] {
        if !breeds.isEmpty {
            filteredCats = catBreeds.filter { breed in
                breed.name.contains(breeds)
          }
        }
        return filteredCats
    }
    
    private func fetchBreeds() {
        isLoading = true
        
         cancellable = request(with: CatsBreedURN())
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    print("Done!")
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: { breeds in
                self.isLoading = false
                self.catBreeds = breeds
            }
    }
    
}

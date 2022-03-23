//
//  BreedFetcher.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import Foundation

final class BreedFetcher: TechStackService, ObservableObject {
    
    @Published var catBreeds: [Breed] = []
    @Published var filteredCats: [Breed] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
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
        request(with: CatsBreedURN()) { [weak self] result in
            
            guard let _self = self else {
                return
            }
            DispatchQueue.main.async {
                _self.isLoading = false
            }
            switch result {
            case .success(let breeds):
                DispatchQueue.main.async {
                    _self.catBreeds = breeds
                }
            case .failure(let error):
                _self.error = error
            }
        }
    }
    
}

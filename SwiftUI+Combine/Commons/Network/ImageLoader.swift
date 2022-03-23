//
//  ImageLoader.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import Foundation
import UIKit

class ImageLoader: TechStackService, ObservableObject {
    
    let url: String?
    
    @Published var image: UIImage? = nil
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    init(url: String?) {
        self.url = url
    }
    
    func fetch() {
        
        guard image == nil && !isLoading else {
            return
        }
        
        guard let urlString = url else {
            errorMessage = TechStackError.invalidURL.localizedDescription
            return
        }
        isLoading = true
        loadImageData(with: URL(string: urlString)) { [weak self] result in
            
            guard let _self = self else {
                self?.errorMessage = TechStackError.invalidSelf.localizedDescription
                return
            }
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    _self.image = UIImage(data: data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    _self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

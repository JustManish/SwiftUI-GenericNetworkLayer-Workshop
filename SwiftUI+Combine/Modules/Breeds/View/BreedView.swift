//
//  BreedView.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import SwiftUI

struct BreedView: View {
    
    let breed: Breed
    let imageSize: CGFloat = 100
    
    var body: some View {
        HStack {
            if breed.image?.url != nil {
                ImageLoadingView(url: breed.image!.url)
            } else {
                Color.gray.frame(width: imageSize, height: imageSize)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(breed.name)
                    .font(.headline)
                Text(breed.temperament)
                    .font(.subheadline)
            }
        }
    }
}

struct BreedView_Previews: PreviewProvider {
    static var previews: some View {
        BreedView(breed: Breed.example1())
            .previewLayout(.fixed(width: 300, height: 150))
    }
}

/**
 AsyncImage(url: URL(string: (breed.image?.url)!)) { phase in
     if let image = phase.image {
         image
             .resizable()
             .frame(width: imageSize, height: imageSize)
             .scaledToFill()
             .clipped()
         // Displays the loaded image.
     } else if phase.error != nil {
         Color.red.frame(width: imageSize, height: imageSize) // Indicates an error.
     } else {
         ProgressView()
             .frame(width: imageSize, height: imageSize)// Acts as a placeholder.
     }
 }*/

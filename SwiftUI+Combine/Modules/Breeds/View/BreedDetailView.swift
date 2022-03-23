//
//  BreedDetailView.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import SwiftUI

struct BreedDetailView: View {
    
    private let imageSize: CGFloat = 300
    let breed: Breed
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: (breed.image?.url)!)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .frame(height: imageSize)
                            .scaledToFit()
                            .clipped()
                        // Displays the loaded image.
                    } else if phase.error != nil {
                        Color.red.frame(width: imageSize, height: imageSize) // Indicates an error.
                    } else {
                        ProgressView()
                            .frame(width: imageSize, height: imageSize)// Acts as a placeholder.
                    }
                }
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(breed.name)
                        .font(.headline)
                    Text(breed.temperament)
                        .font(.footnote)
                    Text(breed.breedExplaination)
                    if breed.isHairless {
                        Text("hairless")
                    }
                    
                    HStack {
                        Text("Energy level")
                        Spacer()
                        ForEach(1..<6) { id in
                            Image(systemName: "star.fill")
                                .foregroundColor(breed.energyLevel > id ? Color.accentColor : Color.gray )
                        }
                    }
                    
                    Spacer()
                }.padding()
                    .navigationBarTitleDisplayMode(.inline)
                
                
            }
        }
    }
}

struct BreedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetailView(breed: Breed.example1())
    }
}

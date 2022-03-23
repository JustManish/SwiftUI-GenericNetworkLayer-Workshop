//
//  ImageLoadingView.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import SwiftUI

struct ImageLoadingView: View {
    private let imageSize: CGFloat = 100
    @StateObject var imageLoader: ImageLoader
    
    init(url: String?) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        Group {
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .clipped()
                
            } else if imageLoader.errorMessage != nil {
                
            } else {
                ProgressView()
                    .frame(width: imageSize, height: imageSize)
            }
        }.onAppear {
            imageLoader.fetch()
        }
    }
}

struct ImageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoadingView(url: "")
    }
}

//
//  RemoteImage.swift
//  Final Project
//
//  Created by user230914 on 4/24/23.
//

import SwiftUI

struct RemoteImage: View {
    let url: String
    @State private var image: UIImage? = nil
    
    var body: some View {
        if let img = image {
            Image(uiImage: img)
                .resizable()
                .scaledToFit()
        } else {
            Image(systemName: "photo")
                .onAppear {
                    fetchImage()
                }
        }
    }
    
    private func fetchImage() {
        guard let imageURL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let imageData = data, let fetchedImage = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.image = fetchedImage
                }
            }
        }.resume()
    }
}

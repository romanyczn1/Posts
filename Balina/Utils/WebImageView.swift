//
//  WebImageView.swift
//  Balina
//
//  Created by Roman Bukh on 16.05.21.
//

import UIKit

class WebImageView: UIImageView {
    
    var dataTask: URLSessionDataTask?
    
    func set(imageURL: String?) {
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = PostCell.emptyImage
            return
        }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        
        self.dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in

            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    self?.handleLoadedImage(data: data, response: response)
                } else {
                    self?.image = PostCell.emptyImage
                }
            }
        }
        dataTask?.resume()
    }
    
    func cancelLoadingImage() {
        dataTask?.cancel()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
        
    }
}

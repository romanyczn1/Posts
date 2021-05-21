//
//  ImagePusher.swift
//  Balina
//
//  Created by Roman Bukh on 17.05.21.
//

import Foundation
import UIKit

struct PostResponse: Codable {
    var id: String
}

final class ImagePusher {
    
    let endpointURI: URL = (URL.init(string: "https://junior.balinasoft.com/api/v2/photo"))!
    let boundary = "example.boundary.\(ProcessInfo.processInfo.globallyUniqueString)"
    
    public func pushIamge(image: UIImage, postId: Int) {
        let imageData = image.jpegData(compressionQuality: 1)!
        let mimeType = imageData.mimeType!
        
        let headers: [String: String] = [
            "Content-Type": "multipart/form-data; boundary=\(boundary)",
            "Accept": "application/json"
        ]
        
        var request = URLRequest(url: endpointURI, method: "POST", headers: headers)
        let parameters = [
            "name": "Roman Bukharin",
            "typeId": "\(postId)"
        ]
        request.httpBody = createHttpBody(binaryData: imageData, mimeType: mimeType, with: parameters)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode ?? 0
            if let data = data, 200 == statusCode {
                let response = try? JSONDecoder().decode(PostResponse.self, from: data)
                print(response?.id)
            }
            
        }
        task.resume()
    }
    
    private func createHttpBody(binaryData: Data, mimeType: String, with parameters: [String: String]?) -> Data {
        var postContent = "--\(boundary)\r\n"
        let fileName = "\(UUID().uuidString).jpeg"
        postContent += "Content-Disposition: form-data; name=\"photo\"; filename=\"\(fileName)\"\r\n"
        postContent += "Content-Type: \(mimeType)\r\n\r\n"
        
        var data = Data()
        guard let postData = postContent.data(using: .utf8) else { return data }
        data.append(postData)
        data.append(binaryData)
        
        // その他パラメータがあれば追加
        if let parameters = parameters {
            var content = ""
            parameters.forEach {
                content += "\r\n--\(boundary)\r\n"
                content += "Content-Disposition: form-data; name=\"\($0.key)\"\r\n\r\n"
                content += "\($0.value)"
            }
            if let postData = content.data(using: .utf8) { data.append(postData) }
        }
        
        // HTTPBodyの終了を設定
        guard let endData = "\r\n--\(boundary)--\r\n".data(using: .utf8) else { return data }
        data.append(endData)
        return data
    }
}

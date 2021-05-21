//
//  NetwotkService.swift
//  Balina
//
//  Created by Roman Bukh on 15.05.21.
//

import Foundation

protocol Networking: class {
    func request(forString string: String, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
    func request(forString string: String, completion: @escaping (Data?, Error?) -> Void) {
        let request = URLRequest(url: URL(string: string)!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, error)
        }.resume()
        
        
    }
}

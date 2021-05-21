//
//  URLR.swift
//  Balina
//
//  Created by Roman Bukh on 17.05.21.
//

import Foundation

extension URLRequest {

    init(url: URL, method: String, headers: [String: String]?) {
        self.init(url: url)
        httpMethod = method

        if let headers = headers {
            headers.forEach {
                setValue($0.1, forHTTPHeaderField: $0.0)
            }
        }
    }
}

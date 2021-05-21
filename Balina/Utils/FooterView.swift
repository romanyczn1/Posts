//
//  FooterView.swift
//  Balina
//
//  Created by Roman Bukh on 17.05.21.
//

import UIKit

class FooterView: UIView {
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    public var isShown: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(loader)
        
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.topAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loader.widthAnchor.constraint(equalToConstant: 50).isActive = true
        loader.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func showLoader() {
        loader.startAnimating()
        isShown = true
    }
    
    func hideLoader() {
        loader.stopAnimating()
        isShown = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

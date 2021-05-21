//
//  PostCell.swift
//  Balina
//
//  Created by Roman Bukh on 16.05.21.
//

import UIKit

final class PostCell: UITableViewCell {
    
    static let reuseIdentifier = "PostCell"
    
    let emptyBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Optima-Bold", size: 21)
        return label
    }()
    
    static let emptyImage = UIImage(named: "emptyImage")!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    func configure(with item: PostCellModel) {
        postImageView.set(imageURL: item.imagePath)
        titleLabel.text = item.title
    }
    
    private func setUpViews() {
        contentView.addSubview(emptyBackgroundView)
        emptyBackgroundView.addSubview(postImageView)
        emptyBackgroundView.addSubview(titleLabel)
        
        emptyBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        emptyBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        emptyBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        emptyBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        postImageView.topAnchor.constraint(equalTo: emptyBackgroundView.topAnchor).isActive = true
        postImageView.leadingAnchor.constraint(equalTo: emptyBackgroundView.leadingAnchor, constant: 0).isActive = true
        postImageView.trailingAnchor.constraint(equalTo: emptyBackgroundView.trailingAnchor, constant: -0).isActive = true
        let newsImageViewHeightAnchor = postImageView.heightAnchor.constraint(equalToConstant: 200)
        newsImageViewHeightAnchor.priority = UILayoutPriority(rawValue: 999)
        newsImageViewHeightAnchor.isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: emptyBackgroundView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: emptyBackgroundView.trailingAnchor, constant: -10).isActive = true
        let titleLabelHeughtAnchor = titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        titleLabelHeughtAnchor.priority = UILayoutPriority(rawValue: 998)
        titleLabelHeughtAnchor.isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: emptyBackgroundView.bottomAnchor, constant: -5).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        postImageView.cancelLoadingImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

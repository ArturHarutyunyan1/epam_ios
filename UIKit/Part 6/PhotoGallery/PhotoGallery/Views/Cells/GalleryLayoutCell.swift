//
//  GalleryLayoutCell.swift
//  PhotoGallery
//
//  Created by Artur Harutyunyan on 25.06.25.
//

import UIKit

class GalleryLayoutCell: UICollectionViewCell {
    var gallery: PhotoGallery?
    weak var delegate: UICollectionViewCellDelegate?
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let title: UILabel = {
        let ul = UILabel()
        ul.translatesAutoresizingMaskIntoConstraints = false
        ul.textColor = .white
        ul.font = UIFont.boldSystemFont(ofSize: 14)
        ul.numberOfLines = 2
        ul.layer.shadowColor = UIColor.black.cgColor
        ul.layer.shadowRadius = 3
        ul.layer.shadowOpacity = 0.7
        ul.layer.shadowOffset = CGSize(width: 0, height: 0)
        ul.layer.masksToBounds = false
        return ul
    }()
    
    private let favorite: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .red
        btn.layer.cornerRadius = 15
        btn.clipsToBounds = true
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.addSubview(title)
        imageView.addSubview(favorite)
        
        favorite.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            title.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            title.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8),
            title.trailingAnchor.constraint(lessThanOrEqualTo: favorite.leadingAnchor, constant: -8),
            
            favorite.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            favorite.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8),
            favorite.widthAnchor.constraint(equalToConstant: 30),
            favorite.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configure(with image: UIImage?, item: PhotoGallery) {
        self.gallery = item
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        imageView.image = image
        title.text = item.title
        
        if item.isFavorite {
            favorite.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: .normal)
        } else {
            favorite.setImage(UIImage(systemName: "heart", withConfiguration: config), for: .normal)
        }
    }
    
    @objc private func addFavorite() {
        guard let item = gallery else { return }
        
        if item.isFavorite {
            delegate?.showAlert("Removed \(item.title) from Favorites.")
        } else {
            delegate?.showAlert("Marked \(item.title) as Favorite!")
        }
        delegate?.toggleFavorite(item)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

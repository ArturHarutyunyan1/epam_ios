//
//  DynamicImageGalleryViewController.swift
//  DynamicImageGallery
//
//  Created by Artur Harutyunyan on 10.07.25.
//

import UIKit

class DynamicImageGalleryViewController: UIViewController {
    private var config: Config?
    private var images: [UIImage] = []
    private let collectionViewLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        if let config = loadConfig() {
            self.config = config
            loadImages()
            collectionView.reloadData()
        }
    }
    
    private func loadConfig() -> Config? {
        guard let url = Bundle.main.url(forResource: "config", withExtension: "json") else {
            showAlert("Configuration file not found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let config = try JSONDecoder().decode(Config.self, from: data)
            
            if let error = config.isValid() {
                showAlert("Invalid configuration: \(error)")
                return nil
            }
            
            return config
        } catch {
            showAlert("\(error.localizedDescription)")
            return nil
        }
    }
    
    private func loadImages() {
        images.removeAll()
        if let config = config {
            for imageName in config.imageNames.prefix(config.imageDisplayCount) {
                if let image = UIImage(named: imageName) {
                    images.append(image)
                } else {
                    showAlert("Image \(imageName) not found")
                }
            }
        }
    }
    
    private func setupCollectionView() {
        collectionViewLayout.scrollDirection = .vertical
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func showAlert(_ message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in })
            self.present(alertController, animated: true)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension DynamicImageGalleryViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        let image = self.images[indexPath.item]
        cell.configure(image)
        return cell
    }
}

extension DynamicImageGalleryViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let config = config {
            let spacing: CGFloat = 10
            let itemsPerRow = CGFloat(config.itemsPerRow)
            let total = (itemsPerRow - 1) * spacing
            let width = (collectionView.bounds.width - total) / itemsPerRow
            return CGSize(width: width, height: width)
        }
        return CGSize(width: 50, height: 50)
    }
}

final class ImageCell : UICollectionViewCell {
    static let reuseId = "ImageCell"

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(_ image: UIImage) {
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview() {
    DynamicImageGalleryViewController()
}

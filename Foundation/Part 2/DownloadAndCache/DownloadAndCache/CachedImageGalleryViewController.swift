//
//  CachedImageGalleryViewController.swift
//  DownloadAndCache
//
//  Created by Artur Harutyunyan on 10.07.25.
//

import UIKit

struct Images : Codable {
    struct Urls : Codable {
        let small: String
    }
    let id: String
    let urls: Urls
}

final class NetworkManager {
    let session = URLSession.shared
    let fileManager = FileManager.default
    let apiKey = ""
    
    func fetchImages() async throws -> [URL] {
        guard let url = URL(string: "https://api.unsplash.com/photos?client_id=\(apiKey)&per_page=30") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let imageObjs = try JSONDecoder().decode([Images].self, from: data)
        let urls = imageObjs.compactMap { URL(string: $0.urls.small) }
        return urls
    }
    
    func cacheData(_ data: Data, _ url: URL) throws {
        let tmpDirectoryURL = fileManager.temporaryDirectory
        let fileName = url.lastPathComponent
        let fileURL = tmpDirectoryURL.appendingPathComponent(fileName)
        
        try data.write(to: fileURL)
    }
    
    func removeCache() {
        let tmpDir = fileManager.temporaryDirectory
        
        do {
            let contents = try fileManager.contentsOfDirectory(at: tmpDir, includingPropertiesForKeys: nil)
            for fileURL in contents {
                if fileURL.pathExtension == "jpg" || fileURL.pathExtension == "jpeg" || fileURL.pathExtension == "png" {
                    try fileManager.removeItem(at: fileURL)
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func downloadImageData(from url: URL) async throws -> Data {
        let tmpDirectoryURL = fileManager.temporaryDirectory
        let fileName = url.lastPathComponent
        let fileURL = tmpDirectoryURL.appendingPathComponent(fileName)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            return try Data(contentsOf: fileURL)
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        try cacheData(data, url)
        return data
    }
    
}

class CachedImageGalleryViewController: UIViewController {
    private let network = NetworkManager()
    private let collectionViewLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout:
                                                        collectionViewLayout)
    private let resetButton = UIButton()
    private var imageUrls: [URL] = []
    private let imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        downloadImages()
        setupResetButton()
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
    
    private func setupResetButton() {
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitle("Clear Cache", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = .systemRed
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        resetButton.layer.cornerRadius = 10
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)

        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            resetButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            resetButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            resetButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func downloadImages() {
        Task {
            do {
                imageUrls = try await network.fetchImages()
                await MainActor.run {
                    collectionView.reloadData()
                }
            } catch {
                showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    @objc private func resetTapped() {
        clearCache()
    }
    
    private func clearCache() {
        network.removeCache()
        showAlert(title: "Cache Cleared", message: "All cached image files have been deleted.")
        imageCache.removeAllObjects()
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in })
        present(alertController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        clearCache()
    }
}

extension CachedImageGalleryViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        
        let urlString = imageUrls[indexPath.item].absoluteString
        
        cell.configure(with: urlString) { [weak self] urlString in
            if let cachedImage = self?.imageCache.object(forKey: urlString as NSString) {
                return cachedImage
            }
            guard let self = self, let url = URL(string: urlString) else { return nil }
            
            do {
                let data = try await self.network.downloadImageData(from: url)
                if let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    return image
                }
            } catch {
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
            return nil
        }
        return cell
    }
}

extension CachedImageGalleryViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let availableWidth = collectionView.bounds.width - padding * 3
        let width = availableWidth / 3
        return CGSize(width: width, height: width)
    }
}

final class ImageCell: UICollectionViewCell {
    static let reuseId = "ImageCell"
    private let imageView = UIImageView()
    private var loadTask: Task<Void, Never>?

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray5
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(with urlString: String, loader: @escaping (String) async -> UIImage?) {
        loadTask?.cancel()
        imageView.image = nil
        
        loadTask = Task {
            let image = await loader(urlString)
            if !Task.isCancelled {
                await MainActor.run {
                    self.imageView.image = image
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        loadTask?.cancel()
    }
}


#Preview() {
    CachedImageGalleryViewController()
}

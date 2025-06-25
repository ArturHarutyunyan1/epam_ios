//
//  PhotoGalleryViewController.swift
//  PhotoGallery
//
//  Created by Artur Harutyunyan on 24.06.25.
//

import UIKit

protocol UICollectionViewCellDelegate : AnyObject {
    func showAlert(_ message: String)
    func toggleFavorite(_ item: PhotoGallery)
}


extension PhotoGalleryViewController: UICollectionViewCellDelegate {
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    
    func toggleFavorite(_ item: PhotoGallery) {
        item.isFavorite.toggle()

        for (sectionIndex, section) in groupedGallery.enumerated() {
            if let itemIndex = section.items.firstIndex(where: { $0 === item }) {
                let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
                collectionView.reloadItems(at: [indexPath])
                break
            }
        }
    }
}

extension PhotoGalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return groupedGallery.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupedGallery[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GalleryLayoutCell else {
            return UICollectionViewCell()
        }
        let item = groupedGallery[indexPath.section].items[indexPath.item]
        cell.gallery = item
        cell.delegate = self
        cell.configure(with: UIImage(named: item.image) ?? UIImage(systemName: "photo"), item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "header",
            for: indexPath) as? GalleryHeaderView else {
            return UICollectionReusableView()
        }
        let date = groupedGallery[indexPath.section].date
        header.configure(with: date)
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44)
    }

}

extension PhotoGalleryViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10
        let isLandscape = view.bounds.width > view.bounds.height
        let itemsPerRow: CGFloat = isLandscape ? 5 : 3
        let total = (itemsPerRow - 1) * spacing
        let width = (collectionView.bounds.width - total) / itemsPerRow
        return CGSize(width: width, height: width + 20)
    }
}

class PhotoGalleryViewController : UIViewController {
    private var gallery: [PhotoGallery] = [
        PhotoGallery(title: "Milky Way", image: "Milkyway", date: "23rd June", isFavorite: false),
        PhotoGallery(title: "Max Verstappen", image: "Max", date: "23rd June", isFavorite: false),
        PhotoGallery(title: "Nature", image: "Nature", date: "23rd June", isFavorite: false),
        PhotoGallery(title: "Mercedes", image: "Car", date: "23rd June", isFavorite: false),
        PhotoGallery(title: "Milky Way", image: "Milkyway", date: "23rd June", isFavorite: false),
        PhotoGallery(title: "Max Verstappen", image: "Max", date: "24th June", isFavorite: false),
        PhotoGallery(title: "Milky Way", image: "Milkyway", date: "24th June", isFavorite: false),
        PhotoGallery(title: "Nature", image: "Nature", date: "24th June", isFavorite: false),
        PhotoGallery(title: "Mercedes", image: "Car", date: "24th June", isFavorite: false),
        PhotoGallery(title: "Max Verstappen", image: "Max", date: "25th June", isFavorite: false),
        PhotoGallery(title: "Mercedes", image: "Car", date: "25th June", isFavorite: false),
        PhotoGallery(title: "Nature", image: "Nature", date: "25th June", isFavorite: false),
        PhotoGallery(title: "Milky Way", image: "Milkyway", date: "25th June", isFavorite: false),
        PhotoGallery(title: "Max Verstappen", image: "Max", date: "25th June", isFavorite: false),
        PhotoGallery(title: "Nature", image: "Nature", date: "25th June", isFavorite: false),
        PhotoGallery(title: "Max Verstappen", image: "Max", date: "25th June", isFavorite: false),
        PhotoGallery(title: "Mercedes", image: "Car", date: "25th June", isFavorite: false),
        PhotoGallery(title: "Max Verstappen", image: "Max", date: "26th June", isFavorite: false),
        PhotoGallery(title: "Milky Way", image: "Milkyway", date: "26th June", isFavorite: false),
        PhotoGallery(title: "Nature", image: "Nature", date: "26th June", isFavorite: false),
        PhotoGallery(title: "Mercedes", image: "Car", date: "26th June", isFavorite: false),
        PhotoGallery(title: "Milky Way", image: "Milkyway", date: "27th June", isFavorite: false),
        PhotoGallery(title: "Nature", image: "Nature", date: "27th June", isFavorite: false),
        PhotoGallery(title: "Mercedes", image: "Car", date: "27th June", isFavorite: false),
        PhotoGallery(title: "Max Verstappen", image: "Max", date: "28th June", isFavorite: false),
        PhotoGallery(title: "Nature", image: "Nature", date: "28th June", isFavorite: false),
        PhotoGallery(title: "Mercedes", image: "Car", date: "29th June", isFavorite: false),
        PhotoGallery(title: "Milky Way", image: "Milkyway", date: "29th June", isFavorite: false),
        PhotoGallery(title: "Max Verstappen", image: "Max", date: "29th June", isFavorite: false),
        PhotoGallery(title: "Nature", image: "Nature", date: "29th June", isFavorite: false),
        PhotoGallery(title: "Mercedes", image: "Car", date: "29th June", isFavorite: false),
    ]

    private var groupedGallery: [(date: String, items: [PhotoGallery])] = []
    private let collectionViewLayoutFlow = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayoutFlow)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupDates()
        setupCollectionView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: {_ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: { _ in
            self.collectionView.reloadData()
        })
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionViewLayoutFlow.scrollDirection = .vertical
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(GalleryLayoutCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(GalleryHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "header")
        collectionView.delegate = self
        collectionView.dataSource = self

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func setupDates() {
        let groupedDict = Dictionary(grouping: gallery) { $0.date }
        let sortedDates = groupedDict.keys.sorted()
        
        groupedGallery = sortedDates.map { (date) in
            (date: date, items: groupedDict[date] ?? [])
        }
    }
}


#Preview() {
    PhotoGalleryViewController()
}

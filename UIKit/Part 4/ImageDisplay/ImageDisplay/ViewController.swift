//
//  ViewController.swift
//  ImageDisplay
//
//  Created by Artur Harutyunyan on 17.06.25.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private var hasSetZoom = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        setupScrollView()
        setupImageView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageLayoutView()
    }

    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.clipsToBounds = true
        
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.bouncesZoom = true
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupImageView() {
        guard let image = UIImage(named: "Image") else { return }
        
        imageView.image = image
        scrollView.addSubview(imageView)
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
    }
    
    private func imageLayoutView() {
        guard let image = imageView.image else { return }
        
        let scrollViewSize = scrollView.bounds.size
        let scaleFactor: CGFloat = (scrollViewSize.width / image.size.width) * 1.8
        
        let newSize = CGSize(
            width: image.size.width * scaleFactor,
            height: image.size.height * scaleFactor
        )
        imageView.frame = CGRect(origin: .zero, size: newSize)
        scrollView.contentSize = newSize

        if !hasSetZoom {
            scrollView.zoomScale = 1.0
            hasSetZoom = true
        }

        centerImage()
    }


    private func centerImage() {
        let scrollViewSize = scrollView.bounds.size
        let imageViewSize = imageView.frame.size
        
        let horizontalInset = max(0, (scrollViewSize.width - imageViewSize.width) / 2)
        let verticalInset = max(0, (scrollViewSize.height - imageViewSize.height) / 2)
        
        scrollView.contentInset = UIEdgeInsets(
            top: verticalInset,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset
        )
        
        var offset = scrollView.contentOffset
        
        if imageViewSize.width < scrollViewSize.width {
            offset.x = -horizontalInset
        } else {
            offset.x = max(min(offset.x, scrollView.contentSize.width - scrollViewSize.width), 0)
        }
        
        if imageViewSize.height < scrollViewSize.height {
            offset.y = -verticalInset
        } else {
            offset.y = max(min(offset.y, scrollView.contentSize.height - scrollViewSize.height), 0)
        }
        
        scrollView.contentOffset = offset
    }

    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.zoomScale == scrollView.minimumZoomScale else { return }
        
        scrollView.contentOffset.x = 0
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard scrollView.zoomScale == scrollView.minimumZoomScale else { return }
        
        scrollView.isDirectionalLockEnabled = true
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        DispatchQueue.main.async {
            self.centerImage()
        }
    }

}

#Preview() {
    ViewController()
}

//
//  PhotoGallery.swift
//  PhotoGallery
//
//  Created by Artur Harutyunyan on 25.06.25.
//


class PhotoGallery {
    let title: String
    let image: String
    let date: String
    var isFavorite: Bool
    
    init(title: String, image: String, date: String, isFavorite: Bool) {
        self.title = title
        self.image = image
        self.date = date
        self.isFavorite = isFavorite
    }
}
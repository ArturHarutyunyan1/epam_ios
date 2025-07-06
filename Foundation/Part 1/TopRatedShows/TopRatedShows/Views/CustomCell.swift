//
//  CustomCell.swift
//  TopRatedShows
//
//  Created by Artur Harutyunyan on 07.07.25.
//

import UIKit

final class CustomCell: UITableViewCell {
    
    private let poster: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 120).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 180).isActive = true
        return iv
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let airDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let rating: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemBlue
        return label
    }()
    
    private let countries: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let popularity: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let overview: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.textColor = .label
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func configure(_ data: TopShows.Results) {
        if let posterPath = data.poster_path {
            ApiHandler.downloadImage(from: "https://image.tmdb.org/t/p/w500\(posterPath)", into: poster)
        }
        name.text = data.name
        airDate.text = "First air date - \(data.first_air_date)"
        rating.text = String(format: "Rating - %.1f", data.vote_average)
        countries.text = "Countries - \(data.origin_country.joined(separator: ", "))"
        popularity.text = String(format: "Popularity - %.0f", data.popularity)
        overview.text = data.overview
    }
    
    private func setupViews() {
        let infoStack = UIStackView(arrangedSubviews: [name, airDate, rating, countries, popularity])
        infoStack.axis = .vertical
        infoStack.spacing = 4
        
        let topStack = UIStackView(arrangedSubviews: [poster, infoStack])
        topStack.axis = .horizontal
        topStack.spacing = 12
        topStack.alignment = .top
        
        let mainStack = UIStackView(arrangedSubviews: [topStack, overview])
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TopShows.swift
//  TopRatedShows
//
//  Created by Artur Harutyunyan on 07.07.25.
//


struct TopShows: Codable {
    let results: [Results]
    
    struct Results: Codable {
        let name: String
        let overview: String
        let first_air_date: String
        let popularity: Double
        let vote_average: Double
        let poster_path: String?
        let origin_country: [String]
    }
}
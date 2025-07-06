//
//  ApiError.swift
//  TopRatedShows
//
//  Created by Artur Harutyunyan on 07.07.25.
//


enum ApiError: Error {
    case invalidURL
    case badResponse
    case decodingError
    case imageDownloadError
    case unknown(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .badResponse: return "Server responded with an error."
        case .decodingError: return "Failed to decode data."
        case .imageDownloadError: return "Image could not be loaded."
        case .unknown(let error): return error.localizedDescription
        }
    }
}
//
//  ApiHandler.swift
//  TopRatedShows
//
//  Created by Artur Harutyunyan on 07.07.25.
//

import UIKit

final class ApiHandler {
    var topShows: TopShows? = nil
    var errorMessage: String = ""
    
    func fetchTopShows() async {
        guard let endpoint = URL(string: "https://api.themoviedb.org/3/tv/top_rated?api_key=API_KEY&language=en-US&page=1") else {
            self.errorMessage = ApiError.invalidURL.localizedDescription
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: endpoint)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ApiError.badResponse
            }
            
            do {
                let decodedData = try JSONDecoder().decode(TopShows.self, from: data)
                self.topShows = decodedData
            } catch {
                throw ApiError.decodingError
            }
        } catch let apiError as ApiError {
            self.errorMessage = apiError.localizedDescription
        } catch {
            self.errorMessage = ApiError.unknown(error).localizedDescription
        }
    }
    
    static func downloadImage(from url: String, into imageView: UIImageView) {
        guard let endpoint = URL(string: url) else {
            DispatchQueue.main.async {
                imageView.image = UIImage(systemName: "photo")
            }
            return
        }
        
        URLSession.shared.dataTask(with: endpoint) { data, response, error in
            if let error = error {
                print(ApiError.unknown(error).localizedDescription)
                DispatchQueue.main.async {
                    imageView.image = UIImage(systemName: "photo")
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print(ApiError.imageDownloadError.localizedDescription)
                DispatchQueue.main.async {
                    imageView.image = UIImage(systemName: "photo")
                }
                return
            }
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
    }
}

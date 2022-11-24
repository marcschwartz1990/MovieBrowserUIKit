//
//  MovieAPI.swift
//  MovieBrowserV2
//
//  Created by Marc-Developer on 11/12/22.
//

import UIKit
protocol MovieManaging {
    func getMovies(searchTerm: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}

final class MovieAPI: MovieManaging {
    private let imageCache = NSCache<AnyObject, AnyObject>()
    let session = URLSession.shared
    var movies = [Movie]()
    
    func getMovies(searchTerm: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/search/movie"
        components.queryItems = [
        URLQueryItem(name: "api_key", value: "f1bba69d2f7b8e57f3db0f3c5cf16c9a"),
        URLQueryItem(name: "query", value: searchTerm)
        ]
        
        guard let url = components.url else {
            print("Invalid URL")
            completion(.failure(URLError.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { (data, resp, error) in
            
            guard let data = data else {
                print("data was nil")
                completion(.failure(DecodingError.missingData))
                return
            }
            
            guard let movieList = try? JSONDecoder().decode(MovieList.self, from: data) else {
                print("Couldn't decode JSON.")
                completion(.failure(DecodingError.decodingError))
                return
            }
            
            completion(.success(movieList.results))
        }
        
        task.resume()
        
        movies.forEach { movie in
            if let posterPath = movie.posterPath {
                let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)
                loadImage(from: url)
            }
        }
    }
    
    func loadImage(from url: URL?) {
        if let url = url {
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                guard
                    let data = data,
                    let newImage = UIImage(data: data)
                else {
                    print("Couldn't load image from url: \(url)")
                    return
                }
                
                self.imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            }
            
            task.resume()
        }
    }
}

struct MovieList: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String?
    let releaseDate: String?
    let voteAverage: Double?
    let overview: String?
    let posterPath: String?
    let id: Int?
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case overview = "overview"
        case posterPath = "poster_path"
        case id = "id"
    }
}

enum URLError: Error {
    case invalidURL
}

enum DecodingError: Error {
    case missingData
    case decodingError
}


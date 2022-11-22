//
//  MovieAPI.swift
//  MovieBrowserV2
//
//  Created by Marc-Developer on 11/12/22.
//

import Foundation

final class MovieAPI {
    
    static let shared = MovieAPI()
    
    func getMovies(searchTerm: String, onCompletion: @escaping ([Movie]) -> ()) {
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
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            guard let data = data else {
                print("data was nil")
                return
            }
            
            guard let movieList = try? JSONDecoder().decode(MovieList.self, from: data) else {
                print("Couldn't decode JSON.")
                return
            }
            
            onCompletion(movieList.results)
        }
        
        task.resume()
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



// https://www.youtube.com/watch?v=t8sYKkST1gs&list=PLJbKhtS4qyYR7WSqTs5V0B0xx3iH7_Iyo&index=2
// Pickup from 12:30

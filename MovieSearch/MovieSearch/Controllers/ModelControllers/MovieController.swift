//
//  MovieController.swift
//  MovieSearch
//
//  Created by David Boyd on 5/7/21.
//

import UIKit

class MovieController {
    
    //MARK: - String Constants
    ///reference:https://api.themoviedb.org/3/search/movie?api_key=bc0e49801e2be685734459bf411b4466&query=Mortal+Kombat
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    static let apiKeyKey = "api_key"
    static let apiKeyValue = "bc0e49801e2be685734459bf411b4466"
    static let searchKey = "query"
    static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")
    
    //MARK: - Functions
    static func fetchMovies(searchTerm: String, completion: @escaping (Result<[Movie.Result], NetworkError>) -> Void) {
        
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let apiQuery = URLQueryItem(name: apiKeyKey, value: apiKeyValue)
        let searchQuery = URLQueryItem(name: searchKey, value: searchTerm)
        components?.queryItems = [apiQuery, searchQuery]
        
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("MOVIE STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(Movie.self, from: data)
                let movieDictionaries = topLevelObject.results
                
                var listOfMovies: [Movie.Result] = []
                
                for movie in movieDictionaries {
                    let movieResult = movie
                    listOfMovies.append(movieResult)
                }
                completion(.success(listOfMovies))
                
            } catch {
                completion(.failure(.thrownError(error)))
                
            }
        }.resume()
    }
    
    static func fetchMoviePosters(for movie: Movie.Result, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {

        guard let imageBaseURL = imageBaseURL else {return completion(.failure(.invalidURL))}
        guard let moviePosterPath = movie.poster_path else {return completion(.failure(.invalidURL))}
        
        let finalImageURL = imageBaseURL.appendingPathComponent(moviePosterPath)
        print(finalImageURL)
        
        URLSession.shared.dataTask(with: finalImageURL) { (data, response, error) in
            
            if let error = error {
                return completion (.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("IMAGE STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let poster = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            
            completion(.success(poster))
            
        }.resume()
    }
    
}//End of class

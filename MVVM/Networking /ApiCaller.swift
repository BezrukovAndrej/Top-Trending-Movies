//
//  NetworkClient.swift
//  MVVM
//
//  Created by Andrey Bezrukov on 23.09.2023.
//

import Foundation

struct ApiCaller {
    
    enum NetworkError: Error {
        case urlError
        case canNotPaeseData
    }
    
    static func getTradingMovies(
        completionHandler: @escaping (_ result: Result<TrandingMoviesModel, NetworkError>)
        -> Void) {
    
            let urlString = NetworkConstant.shared.serverAdress +
            "/trending/all/day?api_key=" +
            NetworkConstant.shared.apiKey
            
            guard let url = URL(string: urlString) else {
                completionHandler(.failure(.urlError))
                return
            }
        
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    completionHandler(.failure(.canNotPaeseData))
                    return
                }
                
                if let response = response as? HTTPURLResponse,
                   response.statusCode < 200 || response.statusCode >= 300 {
                    completionHandler(.failure(.urlError))
                    return
                }
                
                guard let data = data else {
                    completionHandler(.failure(.canNotPaeseData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let trendingMovies = try decoder.decode(TrandingMoviesModel.self, from: data)
                    completionHandler(.success(trendingMovies))
                } catch {
                    completionHandler(.failure(.canNotPaeseData))
                }
            }.resume()
        }
    }

//
//  NetworkConstant.swift
//  MVVM
//
//  Created by Andrey Bezrukov on 23.09.2023.
//

import Foundation

final class NetworkConstant {
    
    public static let shared = NetworkConstant()
    
    private init() {}
    
    public var apiKey: String {
        get {
            // add yout key from themoviedb.org
            "add your key"
        }
    }
    
    public var serverAdress: String {
        get {
            "https://api.themoviedb.org/3"
        }
    }
    
    public var imageServerAdress: String {
        get {
            "https://image.tmdb.org/t/p/w500/"
        }
    }
}

//
//  DetailsMoviesViewModel.swift
//  MVVM
//
//  Created by Andrey Bezrukov on 24.09.2023.
//

import Foundation

final class DetailsMoviesViewModel {
    var movie: Movies
    
    var movieImage: URL?
    var movieTitle: String
    var movieDescription: String
    var movieID: Int
    
    init(movie: Movies) {
        self.movie = movie
        
        self.movieID = movie.id
        self.movieTitle = movie.title ?? movie.name ?? ""
        self.movieDescription = movie.overview
        self.movieImage = makeImageURL(movie.backdropPath)
    }

    private func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstant.shared.imageServerAdress)\(imageCode)")
    }
}

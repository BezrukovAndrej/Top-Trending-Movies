//
//  MovieTableViewModel.swift
//  MVVM
//
//  Created by Andrey Bezrukov on 23.09.2023.
//

import Foundation

final class MovieTableViewCellModel {
    var id: Int
    var title: String
    var date: String
    var rating: String
    var imageUrl: URL?
    
    init(movie: Movies) {
        self.id = movie.id
        self.title = movie.title ?? movie.name ?? ""
        self.rating = "\(movie.voteAverage) / 10"
        self.date = movie.releaseDate ?? movie.firstAirDate ?? ""
        self.imageUrl = makeImageUrl(movie.posterPath)
    }
    
    private func makeImageUrl(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstant.shared.imageServerAdress)\(imageCode)")
    }
}

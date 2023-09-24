//
//  MainViewModel.swift
//  MVVM
//
//  Created by Andrey Bezrukov on 23.09.2023.
//

import Foundation
import UIKit

final class MainViewModel {
    
    var isLoading = Observable(false)
    var cellDataSoure: Observable<[MovieTableViewCellModel]> = Observable(nil)
    var dataSource: TrandingMoviesModel?
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(_ section: Int) -> Int {
        dataSource?.results.count ?? 0
    }
    
    func getData() {
        if isLoading.value ?? true {
            return
        }
        
        isLoading.value = true
        ApiCaller.getTradingMovies { [weak self] result in
            guard let self else { return }
            self.isLoading.value = false
            switch result {
            case .success(let data):
                print("Top Trendng Counts \(data.results.count)")
                self.dataSource = data
                mapCelData()
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    func mapCelData() {
        cellDataSoure.value = dataSource?.results.compactMap({MovieTableViewCellModel(movie: $0)})
    }
    
    func getMovieTitle(_ movie: Movies) -> String {
        return movie.title ?? movie.name ?? ""
    }
    
    func retriveMoview(with id: Int) -> Movies? {
        guard let movie = dataSource?.results.first(where: { $0.id == id }) else {
            return nil
        }
        return movie 
    }
}

//
//  DetailsMoviesViewController.swift
//  MVVM
//
//  Created by Andrey Bezrukov on 24.09.2023.
//

import UIKit
import SDWebImage

final class DetailsMoviesViewController: UIViewController {
    
    var viewModel: DetailsMoviesViewModel
    
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    
    init(viewModel: DetailsMoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setConstraints()
        configView()
    }
    
    func configView() {
        title = "Movie Details"
        view.backgroundColor = .tmWhite
        titleLabel.text = viewModel.movieTitle
        textLabel.text = viewModel.movieDescription
        movieImage.sd_setImage(with: viewModel.movieImage)
    }
}
 
// MARK: - Add subviews / Set constraints

extension DetailsMoviesViewController {
    
    private func addSubviews() {
        [movieImage, titleLabel, textLabel].forEach{view.addViewsTAMIC($0)}
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            movieImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            movieImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            movieImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            
            titleLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
}

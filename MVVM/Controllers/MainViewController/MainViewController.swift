//
//  MainViewController.swift
//  MVVM
//
//  Created by Andrey Bezrukov on 23.09.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    let tableView = UITableView()
    var viewModel = MainViewModel()
    let activityIndicator = UIActivityIndicatorView()
    var cellDataSource: [MovieTableViewCellModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setConstraints()
        configView()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.getData()
    }
    
    private func configView() {
        view.backgroundColor = .tmLightGray
        navigationItem.title = "Top Trending Movies"
        
        setupTableView()
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self, let isLoading else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        viewModel.cellDataSoure.bind { [weak self] movies in
            guard let self, let movies else { return }
            cellDataSource = movies
            reloadTableView()
        }
    }
    
    func openDetail(movieId: Int) {
        guard let movie = viewModel.retriveMoview(with: movieId) else { return }
        let detailsViewModel = DetailsMoviesViewModel(movie: movie)
        let detailsController = DetailsMoviesViewController(viewModel: detailsViewModel)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailsController, animated: true)
        }
    }
}

// MARK: - Add subviews / Set constraints

extension MainViewController {
    
    private func addSubviews() {
        [tableView, activityIndicator].forEach{ view.addViewsTAMIC($0) }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

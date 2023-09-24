//
//  MainViewCell.swift
//  MVVM
//
//  Created by Andrey Bezrukov on 23.09.2023.
//

import UIKit
import SDWebImage

final class MainViewCell: UITableViewCell {
    
    static let identifier = Constants.identifierCell
    
    private let gradientBorderView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var gradientBorder: CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientBorderView.bounds
        gradientLayer.colors = [
            UIColor.color(from: "#FD4C49").cgColor,
            UIColor.color(from: "#46E69D").cgColor,
            UIColor.color(from: "#007BFA").cgColor,
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        return gradientLayer
    }
    
    private let viewCell: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .tmLightGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let imageCell: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setConstraints()
        
        gradientBorder.removeFromSuperlayer()
        
        DispatchQueue.main.async { [weak self] in
            self?.gradientBorderView.layer.insertSublayer(self?.gradientBorder ?? CAGradientLayer(), at: 0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(viewModel: MovieTableViewCellModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        ratingLabel.text = viewModel.rating
        color(rating: viewModel.rating)
        imageCell.sd_setImage(with: viewModel.imageUrl)
    }
    
    private func color(rating: String) {
        if rating > String(7) {
            ratingLabel.textColor = UIColor.systemGreen
        } else {
            ratingLabel.textColor = UIColor.red
        }
    }
}
// MARK: - Add subviews / Set constraints

extension MainViewCell {
    private func addSubviews() {
        contentView.addViewsTAMIC(gradientBorderView)
        [viewCell, imageCell, titleLabel,
         dateLabel, ratingLabel].forEach{ gradientBorderView.addViewsTAMIC($0)}
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            gradientBorderView.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            gradientBorderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),
            gradientBorderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            gradientBorderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            viewCell.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            viewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            viewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            viewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            imageCell.topAnchor.constraint(equalTo: viewCell.topAnchor, constant: 5),
            imageCell.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: 5),
            imageCell.bottomAnchor.constraint(equalTo: viewCell.bottomAnchor, constant: -5),
            imageCell.heightAnchor.constraint(equalToConstant: 100),
            imageCell.widthAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: viewCell.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: viewCell.trailingAnchor, constant:  -8),
            
            dateLabel.leadingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: ratingLabel.topAnchor, constant: -5),
            
            ratingLabel.leadingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 8),
            ratingLabel.bottomAnchor.constraint(equalTo: viewCell.bottomAnchor, constant: -5),
        ])
    }
}

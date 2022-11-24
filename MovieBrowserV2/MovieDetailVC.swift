//
//  MovieDetailVC.swift
//  MovieBrowserV2
//
//  Created by Marc-Developer on 11/13/22.
//

import UIKit

class MovieDetailVC: UIViewController {
    var movie: Movie?
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let imageIV = CustomImageView()
    let descriptionLabel = UILabel()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        setupTitleLabel()
        setupDateLabel()
        setupImageView()
        setupDescriptionLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.text = movie?.title
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.contentMode = .scaleToFill
        titleLabel.numberOfLines = 0

        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 35),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    func setupDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .center
        dateLabel.text = "Release Date: \(movie?.releaseDate ?? "None")"
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 14)
        
        view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor)
        ])
    }
    
    func setupImageView() {
        view.addSubview(imageIV)
        
        imageIV.contentMode = .scaleAspectFit
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        imageIV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageIV.widthAnchor.constraint(equalToConstant: 160).isActive = true
        imageIV.heightAnchor.constraint(equalToConstant: 250).isActive = true
        imageIV.backgroundColor = .red
    }
    
    func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .left
        descriptionLabel.text = movie?.overview
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.contentMode = .scaleToFill
        descriptionLabel.numberOfLines = 0
        
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
}

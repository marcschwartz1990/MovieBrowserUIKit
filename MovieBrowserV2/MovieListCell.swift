//
//  MovieListCell.swift
//  MovieBrowserV2
//
//  Created by Marc-Developer on 11/12/22.
//

import UIKit

class MovieListCell: UITableViewCell {
    var safeArea: UILayoutGuide!
    let imageIV = CustomImageView()
    let titleLabel = UILabel()
    let releaseDateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupView() {
        setupImageView()
        setupTitleLabel()
        setupDateLabel()
    }
    
    func setupImageView() {
        addSubview(imageIV)
        
        imageIV.contentMode = .scaleAspectFit
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageIV.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            imageIV.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageIV.widthAnchor.constraint(equalToConstant: 40),
            imageIV.heightAnchor.constraint(equalToConstant: 40)
        ])

    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageIV.trailingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5)
        ])

        
        titleLabel.font = UIFont(name: "Verdana-Bold", size: 16)
    }
    
    func setupDateLabel() {
        addSubview(releaseDateLabel)
        
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])

        releaseDateLabel.font = UIFont(name: "Verdana", size: 14)
    }
}

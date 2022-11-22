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
        safeArea = layoutMarginsGuide
        setupImageView()
        setupTitleLabel()
        setupDateLabel()
    }
    
    func setupImageView() {
        addSubview(imageIV)
        
        imageIV.contentMode = .scaleAspectFit
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        imageIV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageIV.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageIV.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        imageIV.backgroundColor = .red
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: imageIV.trailingAnchor, constant: 5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        
        titleLabel.font = UIFont(name: "Verdana-Bold", size: 16)
    }
    
    func setupDateLabel() {
        addSubview(releaseDateLabel)
        
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        releaseDateLabel.font = UIFont(name: "Verdana", size: 14)
    }
}

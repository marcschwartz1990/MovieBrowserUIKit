//
//  MovieDetailVC.swift
//  MovieBrowserV2
//
//  Created by Marc-Developer on 11/13/22.
//

import UIKit

class MovieDetailVC: UIViewController {
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Detail View"
    }
}

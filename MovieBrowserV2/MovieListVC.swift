//
//  ViewController.swift
//  MovieBrowserV2
//
//  Created by Marc-Developer on 11/11/22.
//

// Video on SearchController -- https://www.youtube.com/watch?v=Lb8aJa7J4BI

import UIKit

class MovieListVC: UIViewController {
    let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    var safeArea: UILayoutGuide!
    var movieList = [Movie]()
    var searchTerm = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Movie Search"
        navigationItem.searchController = searchController
        
        safeArea = view.layoutMarginsGuide
        tableView.dataSource = self
        
        tableView.register(MovieListCell.self, forCellReuseIdentifier: "cellid")
        
        setupNavigationView()
        setupTableView()
        
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.clearButtonMode = .whileEditing
    }
    
    // MARK: - Setup View
    
    func setupNavigationView() {
        navigationItem.title = self.title
    }
    
    func setupTableView() {
        // Always add the UIView first before setting constraints
        view.addSubview(tableView)
        
        tableView.register(MovieListCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        //
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
    // MARK: - UITableViewDataSource
   
extension MovieListVC: UITableViewDataSource {
    
    //MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let movie = movieList[indexPath.row]
        
        guard let movieListCell = cell as? MovieListCell else {
            return cell
        }
        
        movieListCell.titleLabel.text = movie.title
        movieListCell.releaseDateLabel.text = movie.releaseDate
        
        // There is a better way to unwrap posterPath where you can give the cell a placeholder.
        
        if movie.posterPath != nil {
            if let url = URL(string: "https://image.tmdb.org/t/p/w500" + movie.posterPath!) {
                movieListCell.imageIV.loadImage(from: url)
            }
        }
        
        return cell
    }
}
    
extension MovieListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.movieList[indexPath.row]
        let detailVC = MovieDetailVC()
        detailVC.movie = movie
        show(detailVC, sender: self)
    }
}

extension MovieListVC: UISearchBarDelegate {
    
    //MARK: - Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        // Perform action on search click
        let fetchMovies = { (fetchedMovieList: [Movie]) in
            DispatchQueue.main.async {
                self.movieList = fetchedMovieList
                self.tableView.reloadData()
            }
        }
        MovieAPI.shared.getMovies(searchTerm: searchTerm, onCompletion: fetchMovies)
        print("Search Term: \(searchTerm)")
    }
}



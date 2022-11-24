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
    var movieList = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    var searchTerm = ""
    let movieAPI: MovieManaging = MovieAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Movie Search"
        navigationItem.searchController = searchController
        
        // tableView.register relates to tableView.dequeReusableCell in cellForRowAt
        tableView.register(MovieListCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        tableView.delegate = self
        
        setupNavigationView()
        setupTableView()
        
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.clearButtonMode = .whileEditing
        searchController.searchBar.showsCancelButton = false
    }
    
    // MARK: - Setup View
    
    func setupNavigationView() {
        navigationItem.title = self.title
    }
    
    func setupTableView() {
        // Always add the UIView first before setting constraints
        view.addSubview(tableView)
        


        //
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }
}
    // MARK: - UITableViewDataSource
   
extension MovieListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let movie = movieList[indexPath.row]
        
        // ask Sam about casting to different type... as?
        guard let movieListCell = cell as? MovieListCell else {
            return cell
        }
        
        movieListCell.titleLabel.text = movie.title
        movieListCell.releaseDateLabel.text = movie.releaseDate
        
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
        
//        let fetchMovies = { (fetchedMovieList: [Movie]) in
//            DispatchQueue.main.async {
//                self.movieList = fetchedMovieList
//                self.tableView.reloadData()
//            }
//        }
        movieAPI.getMovies(searchTerm: searchTerm) { result in
            switch result {
            case .success(let movies):
                print(movies)
                self.movieList = movies
            case .failure(let error):
                print(error)
                self.presentErrorAlert(error: error)
            }
            
        }
        print("Search Term: \(searchTerm)")
    }
    
    func presentErrorAlert(error: Error) {
            let alertController = UIAlertController(
                title: "Error fetching movie",
                message: "\(error.localizedDescription)",
                preferredStyle: .alert)
            let soundsGoodAction = UIAlertAction(
                title: "Ok",
                style: .default)
            alertController.addAction(soundsGoodAction)
            present(alertController, animated: true)
        }
}



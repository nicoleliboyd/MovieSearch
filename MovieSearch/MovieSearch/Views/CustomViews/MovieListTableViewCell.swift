//
//  MovieListTableViewCell.swift
//  MovieSearch
//
//  Created by David Boyd on 5/7/21.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!

    //MARK: - Properties
    var movie: Movie.Result? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Functions

    func updateViews() {
        guard let movie = movie else {return}
        
        movieTitleLabel.text = movie.original_title
        movieRatingLabel.text = "Rating: \(movie.vote_average)"
        movieOverviewLabel.text = movie.overview
        
        MovieController.fetchMoviePosters(for: movie) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let poster):
                    self.moviePosterImageView.image = poster
                    
                case .failure(let error):
                    self.moviePosterImageView.image = UIImage(named: "notAvailableImage")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }

}//End of class

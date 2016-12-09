//
//  MovieCell.swift
//  top250movies
//
//  Created by Emre Dogan on 09/11/16.
//  Copyright © 2016 Emre Dogan. All rights reserved.
//

import UIKit
import CoreData


class MovieCell: UITableViewCell {
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieLength: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieStatus: UIImageView!
    
    
    
    

    func configureCell(movie: Movie) {
        movieTitle.text = movie.title
        movieRating.text = movie.rating
        movieLength.text = movie.length
        movieYear.text = movie.year
        movieImage.image = movie.getMovieImg()
        
    }
}

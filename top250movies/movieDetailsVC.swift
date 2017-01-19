//
//  movieDetailsVC.swift
//  top250movies
//
//  Created by Emre Dogan on 19/01/17.
//  Copyright © 2017 Emre Dogan. All rights reserved.
//

import Foundation
import UIKit

class movieDetailsVC: UIViewController {
    
    
    @IBOutlet weak var movieDetailImage: UIImageView!
    
    var movie: Movie?
    var movImg = UIImage()
    
    
    
    override func viewDidLoad() {
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("budur: \(movie)")
        movieDetailImage.image = movie?.getMovieImg()
        
    }
    
}



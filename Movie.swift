//
//  Movie.swift
//  top250movies
//
//  Created by Emre Dogan on 09/11/16.
//  Copyright © 2016 Emre Dogan. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Movie: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
        
    

    
    
    func setMovieImg(_ img: UIImage) {
        
        let data = UIImageJPEGRepresentation(img, 1)
        self.image = data
        
    }
    
    func getMovieImg() -> UIImage {
        
        if let image = image {
            
            let img = UIImage(data: self.image! as Data)
            return img!
            
        } else {
            
            let img = UIImage(named: "sample2")
            return img!
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    

}

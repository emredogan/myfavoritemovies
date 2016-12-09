//
//  addMovieViewController.swift
//  top250movies
//
//  Created by Emre Dogan on 20/11/16.
//  Copyright © 2016 Emre Dogan. All rights reserved.
//

import UIKit
import CoreData

class addMovieViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextView: UITextField!
    
    @IBOutlet weak var yearTextView: UITextField!
    
    
    
    
    @IBAction func addMovieButton(sender: AnyObject) {
        
        
            let urlString = "http://www.omdbapi.com/?t=\(String(titleTextView.text!))&y=\(String(yearTextView.text!))&plot=short&r=json"
            print(urlString)

        
        
            let session = NSURLSession.sharedSession()
            
            do {
                sleep(1)
            } catch {
                print("can't wait")
            }
            
            
            let url = NSURL(string: urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
            
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: context)!
            let movie = Movie(entity: entity, insertIntoManagedObjectContext: context)
        
        

        
        
            
            
            session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response:  NSURLResponse?, error: NSError?) -> Void in
                
                if let responseData = data {
                    
                    print("processing \(urlString)")
                    
                    
                    
                    
                    
                    do {
                        
                        let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        
                        
                        
                        print(urlString)
                        
                        
                        if let rating = json["imdbRating"] as? String {
                            
                            let rating = json["imdbRating"] as! String
                            let length = json["Runtime"] as! String
                            let title = json["Title"] as! String
                            let year = json["Year"] as! String
                            let imageLink = json["Poster"] as! String
                            var imageURL = NSURL(string: "http://www.teachthought.com/wp-content/uploads/2013/10/designinspirationdotnet.jpg")
                            
                            
                            
                            
                            
                            if self.verifyUrl(imageLink) == true {
                                
                                imageURL = NSURL(string: imageLink)
                                
                            } else {
                                
                                imageURL = NSURL(string: "http://www.teachthought.com/wp-content/uploads/2013/10/designinspirationdotnet.jpg")
                                
                            }
                            
                            
                            
                            
                            
                            
                            let imagedData = NSData(contentsOfURL: imageURL!)!
                            
                            
                            
                            var image = UIImage(data: imagedData)
                            
                            
                            
                            movie.title = title
                            movie.rating = rating
                            movie.length = length
                            movie.year = year
                            
                            if let image = image {
                                
                                movie.setMovieImg(image)
                                
                            } else {
                                image = UIImage(named:"sample")
                                movie.setMovieImg(image!)
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                            context.insertObject(movie)
                            print("movie \(movie.title))")
                            
                            do {
                                try context.save()
                                print("success \(movie.title))")
                                
                                
                                
                            } catch {
                                print("Could not save movie")
                            }
                            
                            
                            

                            
                            
                            
                        } else {
                            
                            
                            if self.titleTextView.text == "efka" {
                                
                                movie.title = "Evelina Sluka"
                                movie.length = "12/2015"
                                movie.rating = "10"
                                let img = UIImage(named: "efka")
                                
                                movie.setMovieImg(img!)
                                
                                
                            } else {
                                
                                
                                movie.title = self.titleTextView.text
                                
                                
                                
                                context.insertObject(movie)
                                print("movie \(movie.title))")
                                
                                do {
                                    try context.save()
                                    print("success \(movie.title))")
                                    
                                    
                                    
                                } catch {
                                    print("Could not save movie")
                                }
                                
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                                                
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    } catch {
                        
                        print("could not serialize")
                        
                    }
                    
                    
                    
                    
                    
                }
                
            }).resume()
        
        do {
            sleep(2)
        } catch {
            print("can't wait")
        }

        
        self.navigationController?.popViewControllerAnimated(true)
        
        }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    

    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.sharedApplication().canOpenURL(url)
            }
        }
        return false
}
}
    
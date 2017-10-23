//
//  addMovieViewController.swift
//  top250movies
//
//  Created by Emre Dogan on 20/11/16.
//  Copyright © 2016 Emre Dogan. All rights reserved.
//

import UIKit
import CoreData
import SystemConfiguration

class addMovieViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextView: UITextField!
    
    @IBOutlet weak var yearTextView: UITextField!
    
    
    
    
    @IBAction func addMovieButton(_ sender: AnyObject) {
        
        if isInternetAvailable() == false {
            let alert = UIAlertController(title: "Error", message: "Check that you have valid internet connection and try again", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
//            let urlString = "http://www.omdbapi.com/?t=\((titleTextView.text!))&y=\((yearTextView.text!))&plot=short&r=json"
            
            let urlString = "http://theapache64.xyz:8080/movie_db/search?keyword=\((titleTextView.text!))"
            
            
      //      "http://theapache64.xyz:8080/movie_db/search?keyword=[YOUR-KEYWORD]"
            print("url string: EMRE: \(urlString)")
            
            
            
            let session = URLSession.shared
            
             print("Devam 1")
            
            
            let url = URL(string: urlString.addingPercentEscapes(using: String.Encoding.utf8)!)!
            
            let app = UIApplication.shared.delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)!
            let movie = Movie(entity: entity, insertInto: context)
            
           
            
            
            
            
            
            
            
            session.dataTask(with: url, completionHandler: { (data: Data?, response:  URLResponse?, error: Error?) -> Void in
                
                if let responseData = data {
                    
                    print("processing \(urlString)")
                    
                    
                    
                    
                    
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        
                        
                        
                        print(urlString)
                        
                        
                        if let rating = json["imdbRating"] as? String {
                            
                            let rating = json["imdbRating"] as! String
                            let length = json["Runtime"] as! String
                            var title = json["Title"] as! String
                            let year = json["Year"] as! String
                            let imageLink = json["Poster"] as! String
                            var imageURL = URL(string: "http://www.teachthought.com/wp-content/uploads/2013/10/designinspirationdotnet.jpg")
                            
                            
                            
                            
                            
                            if self.verifyUrl(imageLink) == true {
                                
                                imageURL = URL(string: imageLink)
                                
                            } else {
                                
                                imageURL = URL(string: "http://www.teachthought.com/wp-content/uploads/2013/10/designinspirationdotnet.jpg")
                                
                            }
                            
                            
                            
                            
                            
                            
                            let imagedData = try! Data(contentsOf: imageURL!)
                            
                            
                            
                            let image = UIImage(data: imagedData)
                            
                            
                            
                            movie.title = title
                            movie.rating = rating
                            movie.length = length
                            movie.year = year
                            
                            if movie.title == "" {
                                movie.title = "Please wait"
                            }
                            
                            if let image = image {
                                
                                movie.setMovieImg(image)
                                
                            } else {
                                movie.setMovieImg(image!)
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                            context.insert(movie)
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
                                
                                
                                
                                context.insert(movie)
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
            
            //        do {
            //            sleep(2)
            //        } catch {
            //            print("can't wait")
            //        }
            
            
            let _ = navigationController?.popViewController(animated: true)


            
        }

        
        
        
        
        }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    
    

    func verifyUrl (_ urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = URL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url)
            }
        }
        print("can't verify url")
        return false
}
}
    

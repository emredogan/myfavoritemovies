//
//  ViewController.swift
//  top250movies
//
//  Created by Emre Dogan on 07/11/16.
//  Copyright © 2016 Emre Dogan. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    var shouldShowSearchResults = false
    
    
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addMovie(sender: AnyObject) {
        
        
       
        
        
        

        
        
    }
    
    
    @IBAction func sortAz(sender: AnyObject) {
        
        SortList()
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor.darkGrayColor()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        self.tableView.backgroundColor = UIColor.lightGrayColor()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
        tableView.addGestureRecognizer(longPressRecognizer)
        
        
        
                
//        do {
//            sleep(5)
//        } catch {
//            print("can't wait")
//        }
//        
        
        self.navigationItem.title = "MY MOVIES";

        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.blackColor(),
             NSFontAttributeName: UIFont(name: "ImpactT", size: 25)!]
        
        
        
        
        
//        
//        do {
//            sleep(5)
//        } catch {
//            print("can't wait")
//        }

        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
//        var i = 0
//        
//        while i < 5 {
//            
//            
//            
//            
//            let urlString = "http://www.omdbapi.com/?t=\(moviesList[i])&y=\(moviesYears[i])&plot=short&r=json"
//            
////            do {
////                sleep(1)
////            } catch {
////                print("can't wait")
////            }
//            
//            
//            
//            
//            
//            let session = NSURLSession.sharedSession()
//            
//            do {
//                sleep(1)
//            } catch {
//                print("can't wait")
//            }
//
//            
//            let url = NSURL(string: urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
//            
//            let app = UIApplication.sharedApplication().delegate as! AppDelegate
//            let context = app.managedObjectContext
//            let entity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: context)!
//            let movie = Movie(entity: entity, insertIntoManagedObjectContext: context)
//            
//            print(i)
//            
//            
//            
//            session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response:  NSURLResponse?, error: NSError?) -> Void in
//                
//                if let responseData = data {
//                    
//                    print("processing \(urlString)")
//                    print(i)
//                    
//                    
//                    
//                    
//                    
//                    do {
//                        
//                        let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//                        
//                        
//                        
//                        print(urlString)
//                        print(self.moviesList[i])
//                        print(self.moviesYears[i])
//                        
//                        
//                        
//                        
//                        let rating = json["imdbRating"] as! String
//                        let length = json["Runtime"] as! String
//                        let title = json["Title"] as! String
//                        let year = json["Year"] as! String  
//                        let imageLink = json["Poster"] as! String
//                        var imageURL = NSURL(string: "http://www.teachthought.com/wp-content/uploads/2013/10/designinspirationdotnet.jpg")
//                        
//                        
//                        
//                        if self.verifyUrl(imageLink) == true {
//                            
//                            imageURL = NSURL(string: imageLink)
//                            
//                        } else {
//                            
//                            imageURL = NSURL(string: "http://www.teachthought.com/wp-content/uploads/2013/10/designinspirationdotnet.jpg")
//                            
//                        }
//                        
//                        
//                        
//                        
//                        
//                        
//                        let imagedData = NSData(contentsOfURL: imageURL!)!
//                        
//                        
//                        
//                        var image = UIImage(data: imagedData)
//                        
//                        
//                        
//                        movie.title = title
//                        movie.rating = rating
//                        movie.length = length
//                        movie.year = year
//                        
//                        if let image = image {
//                            
//                            movie.setMovieImg(image)
//                            
//                        } else {
//                            image = UIImage(named:"matrix.png")
//                        }
//                        
//                        
//                        
//                        
//                        
//                    
//                        
//                        
//                        context.insertObject(movie)
//                        print("movie \(movie.title))")
//                        
//                        do {
//                            try context.save()
//                            print("success \(movie.title))")
//                            self.fetchAndSetResults()
//                        } catch {
//                            print("Could not save movie")
//                        }
//                        
//                        
//                        
//                        
//                        
//                    
//                    
//                        
//                        
//                    } catch {
//                        
//                        print("could not serialize")
//                        
//                    }
//                    
//                    
//                    
//                    
//                    
//                }
//                
//            }).resume()
//            
//            if i == 249  {
//                
//                break
//            } else {
//                
//                i = i + 1
//                
//            }
//            
//            
//            
//
//            
//        }
//        
//        for movie in movies {
//            print (movie.title)
//        }
//        
//        
//        
//        
//        
//        
//        
//        
//       
//        
        
    }
    
    func longPress(longPressRecognizer: UILongPressGestureRecognizer) {
        
        if longPressRecognizer.state == UIGestureRecognizerState.Began {
            
            let touchPoint = longPressRecognizer.locationInView(self.tableView)
            if let indexPath = tableView.indexPathForRowAtPoint(touchPoint) {
                
                let alertController = UIAlertController(title: "Alert", message: "Delete post?", preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                    
                }
                alertController.addAction(cancelAction)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action: UIAlertAction!) in
                    
                    let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let context:NSManagedObjectContext = appDel.managedObjectContext
                    context.deleteObject(self.movies[indexPath.row] )
                    self.movies.removeAtIndex(indexPath.row)
                    do {
                        try context.save()
                    } catch _ {
                    }
                    
                    // remove the deleted item from the `UITableView`
                    self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    self.TabelaSemDados(self.movies)
                    self.tableView.reloadData()
                    
                }
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
            }
        }
        
        
        
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
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        tableView.reloadData()
        TabelaSemDados(self.movies)
    }
    
    func SortList() { // should probably be called sort and not filter
        movies.sortInPlace() { $0.title < $1.title } // sort the fruit by name
        tableView.reloadData(); // notify the table view the data has changed
        
        let alert = UIAlertController(title: "Success", message: "Movies are sorted alphabetically", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func TabelaSemDados(recipes:NSArray){
        if recipes.count == 0 {
            tableView.tableFooterView = UIView(frame: CGRect.zero)
            
            
            var label = UILabel()
            label.frame.size.height = 125
            label.frame.size.width = tableView.frame.size.width
            
            label.numberOfLines = 2
            label.textColor = UIColor.grayColor()
            label.text = "  Press + to add new movies"
            label.textAlignment = .Natural
            
            label.tag = 1
            
            self.tableView.addSubview(label)
        }else{
            self.tableView.viewWithTag(1)?.removeFromSuperview()
        }
    }
    
    
    

    
    
    
    
    
    
    
    func fetchAndSetResults() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Movie")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.movies = results as! [Movie]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    
    
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as? MovieCell {
            
            
            
            let movie : Movie
            
            
            
            if searchController.active && searchController.searchBar.text != "" {
                movie = filteredMovies[indexPath.row]
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.configureCell(movie)
            } else {
                let movie = movies[indexPath.row]
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.configureCell(movie)
            }
            
           
            
           
            
            
            
            
            cell.backgroundColor = UIColor.clearColor()
            
            return cell
        } else {
            
            return MovieCell()
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredMovies.count
        }
        return movies.count
    }
    
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredMovies = movies.filter { movie in
            return movie.title!.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    
    
   

    

}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}


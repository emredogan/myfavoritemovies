//
//  ViewController.swift
//  top250movies
//
//  Created by Emre Dogan on 07/11/16.
//  Copyright © 2016 Emre Dogan. All rights reserved.
//

import UIKit
import CoreData
import SystemConfiguration
import Toast_Swift


// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}




class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    
    
    
    

    
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    var shouldShowSearchResults = false
    
    
    var refreshControl: UIRefreshControl!
    
    
    
    
    
        
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addMovie(_ sender: UIButton!) {
        
                
        
       
        
        
        

        
        
    }
    
    
    @IBAction func sortAz(_ sender: AnyObject) {
        
        SortList()
        
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myTimer = Timer(timeInterval: 1.0, target: self, selector: "reloadTableData", userInfo: nil, repeats: true)
        RunLoop.main.add(myTimer, forMode: RunLoopMode.defaultRunLoopMode)
        
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        
        self.tableView.separatorColor = UIColor.darkGray
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        self.tableView.backgroundColor = UIColor.lightGray
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(_:)))
        tableView.addGestureRecognizer(longPressRecognizer)
  
        
        self.navigationItem.title = "MY MOVIES";

        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.black,
             NSFontAttributeName: UIFont(name: "ImpactT", size: 25)!]
        
        
        
        
        
 
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
 
    }
    
    
    
    func longPress(_ longPressRecognizer: UILongPressGestureRecognizer) {
        
        if longPressRecognizer.state == UIGestureRecognizerState.began {
            
            let touchPoint = longPressRecognizer.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                
                let alertController = UIAlertController(title: "Alert", message: "Delete post?", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                    
                }
                alertController.addAction(cancelAction)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction!) in
                    
                    let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context:NSManagedObjectContext = appDel.managedObjectContext
                    context.delete(self.movies[indexPath.row] )
                    self.movies.remove(at: indexPath.row)
                    do {
                        try context.save()
                    } catch _ {
                    }
                    
                    // remove the deleted item from the `UITableView`
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    self.TabelaSemDados(self.movies as NSArray)
                    self.tableView.reloadData()
                    
                }
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true) {
                    // ...
                }
            }
        }
        
        
        
    }
    

    
    
    
    func reloadTableData() {
        
        tableView.reloadData()
        
        
    }
    
    func refresh(sender:AnyObject) {
        tableView.reloadData()
        
        
        
        refreshControl.endRefreshing()
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
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchAndSetResults()
        tableView.reloadData()
        TabelaSemDados(self.movies as NSArray)
        movies.sort() { $0.title < $1.title } // sort the fruit by name
        
        self.view.makeToast("Movie list is refreshed")
        
        
        
    }
    
    
    
    func SortList() { // should probably be called sort and not filter
        movies.sort() { $0.title < $1.title } // sort the fruit by name
        tableView.reloadData(); // notify the table view the data has changed
        
        let alert = UIAlertController(title: "Success", message: "Movies are sorted alphabetically", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
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
    
    func TabelaSemDados(_ recipes:NSArray){
        if recipes.count == 0 {
            tableView.tableFooterView = UIView(frame: CGRect.zero)
            
            
            let label = UILabel()
            label.frame.size.height = 125
            label.frame.size.width = tableView.frame.size.width
            
            label.numberOfLines = 2
            label.textColor = UIColor.gray
            label.text = "  Press + to add new movies"
            label.textAlignment = .natural
            
            label.tag = 1
            
            self.tableView.addSubview(label)
        }else{
            self.tableView.viewWithTag(1)?.removeFromSuperview()
        }
    }
    
    
    

    
    
    
    
    
    
    
    func fetchAndSetResults() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        
        do {
            let results = try context.fetch(fetchRequest)
            self.movies = results as! [Movie]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    
    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell {
            
            
            
            var movie : Movie
            
            
            
            if searchController.isActive && searchController.searchBar.text != "" {
                movie = filteredMovies[indexPath.row]
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.configureCell(movie)
                
                
                
                print("movie: \(movie)")
                
                
                
            } else {
                movie = movies[indexPath.row]
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.configureCell(movie)
                print("moviess: \(movie)")
                
                
            }
            
           
            
           
            
            
            
            
            cell.backgroundColor = UIColor.clear
            
            return cell
        } else {
            
            return MovieCell()
        }
        
        
    }
    
    func tableView(_ didSelectRowAttableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        var movie: Movie!
        
        
        
        
        if searchController.isActive && searchController.searchBar.text != "" {
            movie = filteredMovies[(indexPath.row)]
            
            
            
            
            
        } else {
            movie = movies[(indexPath.row)]
            
        }
        
        //    performSegue(withIdentifier: "movieDetailsVC", sender: movie)
        print("noww")
        
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMovies.count
        }
        return movies.count
    }
    
    func deleteAllData(_ entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMovies = movies.filter { movie in
            return movie.title!.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetailsVC" {
            if let movieDetailsVC = segue.destination as? movieDetailsVC {
                let selectedRow = tableView.indexPathForSelectedRow?.row
                var movie: Movie!
                if searchController.isActive && searchController.searchBar.text != "" {
                    movie = filteredMovies[(selectedRow)!]
                    
                    
                    
                    
                    
                } else {
                    movie = movies[(selectedRow)!]
                    
                }
                
                movieDetailsVC.movie = movie
            }
        }
    }
    
    
   

    

}



extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}




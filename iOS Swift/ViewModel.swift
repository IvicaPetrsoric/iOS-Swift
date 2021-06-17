//
//  ViewModel.swift
//  TopMovie
//
//  Created by ivica petrsoric on 24/06/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    
    @IBOutlet var moviesClient: MoviesClient!
    var movies: [NSDictionary]?
    
    func fetchMovies(completion: @escaping() -> ()) {
        moviesClient.fetchMovies { movies in
            self.movies = movies
            completion()
        }
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func titleForItemAtIndexPath(indexPath: IndexPath) -> String {
        return movies?[indexPath.row].value(forKeyPath: "im:name.label") as? String ?? "Error for key"
    }

}

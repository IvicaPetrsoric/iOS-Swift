//
//  TrendingCell.swift
//  youtube
//
//  Created by Ivica OS X on 30/06/17.
//  Copyright © 2017 Ivica OS X. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed{ (videos) in
            
            self.videos = videos
            self.collectionView.reloadData()
        }
        
    }
    
}

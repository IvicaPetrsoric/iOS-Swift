//
//  Article.swift
//  GoodNews
//
//  Created by ivica petrsoric on 26/10/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import Foundation

struct ArticleList: Decodable {
    
    let articles: [Article]
    
}

struct Article: Decodable {
    
    var title: String?
    var description: String?
    
}



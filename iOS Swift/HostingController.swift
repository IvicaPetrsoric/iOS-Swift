//
//  HostingController.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 15/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import Foundation

import SwiftUI

class HostingController: UIHostingController<VideoListView> {
    
    init() {
        super.init(rootView: VideoListView())

    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

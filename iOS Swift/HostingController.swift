//
//  HostingController.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 15/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftData

class HostingController: UIHostingController<AnyView> {

    init() {
        let container = try! ModelContainer(
            for: CodeBreaker.self
        )

        super.init(
            rootView: AnyView(
                GameChooser()
                    .modelContainer(container)
            )
        )
    }

    @objc required dynamic init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

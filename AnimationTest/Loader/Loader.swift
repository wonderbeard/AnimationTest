//
//  Loader.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation

final class Loader {
    private let path: String
    private let ext: String
    
    init (path: String, ext: String) {
        self.path = path
        self.ext = ext
    }
}

extension Loader: LoaderProtocol {
    
}

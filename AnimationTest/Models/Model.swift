//
//  Model.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation

final class Model {
    private let loader: LoaderProtocol
    
    init(loader: LoaderProtocol) {
        self.loader = loader
    }
}

extension Model: ModelProtocol {
    
}

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
    weak var output: ModelOutput?

    var status: AnimationModelStatus = .empty {
        didSet {
            output?.didUpdate(status: status)
        }
    }
    
    init(loader: LoaderProtocol) {
        self.loader = loader
    }
}

extension Model: ModelProtocol {    
    
    func load() {
        status = .loading
        loader.load { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let phases):
                strongSelf.status = .success(phases)
            case .failure(let error):
                strongSelf.status = .failure(error)
            }
        }
    }
}

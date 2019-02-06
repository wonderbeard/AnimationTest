//
//  Model.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation

final class AnimationModel {
    
    weak var output: AnimationModelOutput?
    
    private let loader: PhaseListLoaderProtocol
    
    private var status: AnimationModelStatus = .empty {
        didSet {
            output?.didUpdate(status: status)
        }
    }
    
    init(loader: PhaseListLoaderProtocol) {
        self.loader = loader
    }
}

extension AnimationModel: AnimationModelProtocol {    
    
    func load() {
        switch status {
        case .success:
            output?.didUpdate(status: status)
        case .empty, .failure:
            reload()
        case .loading:
            break
        }
    }
    
    func reload() {
        status = .loading
        loader.load { [weak self] result in
            switch result {
            case .success(let phases):
                self?.status = .success(phases)
            case .failure(let error):
                self?.status = .failure(error)
            }
        }
    }
}

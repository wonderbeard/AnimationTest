//
//  Presenter.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

final class Presenter {
    private let model: ModelProtocol
    weak var view: ViewProtocol?
    
    init(model: ModelProtocol) {
        self.model = model
        model.output = self
    }
}

extension Presenter: PresenterProtocol {
    func load() {
        model.load()
    }
}

extension Presenter: ModelOutput {
    func didUpdate(status: AnimationModelStatus) {
        switch status {
        case .empty:
            break
        case .loading:
            break
        case .failure(let error):
            break
        case .success(let phases):
            view?.set(phases: phases)
        }
        
    }
}

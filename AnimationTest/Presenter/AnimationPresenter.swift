//
//  Presenter.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation

final class AnimationPresenter {
    
    private let model: AnimationModelProtocol
    weak var view: AnimationViewProtocol?
    private var breathe: BreathGenerator?
    
    init(model: AnimationModelProtocol) {
        self.model = model
        model.output = self
    }
}

extension AnimationPresenter: AnimationPresenterProtocol {
    
    func load() {
        model.load()
    }
    
    func startSequence() {
        guard let breathe = breathe, !breathe.isRunning else {
            return
        }
        breathe.start()
    }
}

extension AnimationPresenter: AnimationModelOutput {
    
    func didUpdate(status: AnimationModelStatus) {
        DispatchQueue.main.async { [unowned self] in
            switch status {
            case .empty:
                break
            case .loading:
                self.view?.setLoading()
            case .failure(let error):
                self.view?.set(error: error)
            case .success(let phases):
                let sequence = PhaseSequence(phases: phases)
                self.breathe = BreathGenerator(sequence: sequence)
                self.view?.onReady(sequence: sequence)
                self.view?.set(phases: phases)
            }
        }
    }
}

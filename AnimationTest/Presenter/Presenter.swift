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
    private var breathe: BreathGenerator?
    
    init(model: ModelProtocol) {
        self.model = model
        model.output = self
    }
}

extension Presenter: PresenterProtocol {
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

extension Presenter: ModelOutput {
    func didUpdate(status: AnimationModelStatus) {
        switch status {
        case .empty:
            break
        case .loading:
            view?.setLoading()
        case .failure(let error):
            view?.set(error: error)
        case .success(let phases):
            let sequence = PhaseSequence(phases: phases)
            self.breathe = BreathGenerator(sequence: sequence)
            view?.onReady(sequence: sequence)
            view?.set(phases: phases)
        }
        
    }
}

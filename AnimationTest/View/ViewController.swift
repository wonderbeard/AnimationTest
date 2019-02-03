//
//  ViewController.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var animationView: UIView!
    @IBOutlet private weak var phaseStackView: UIStackView!
    @IBOutlet private weak var phaseNameLabel: UILabel!
    @IBOutlet private weak var phaseDurationLabel: UILabel!
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    @IBOutlet private weak var remainingTimeStackView: UIStackView!
    @IBOutlet private weak var remainingLabel: UILabel!
    @IBOutlet private weak var remainingTimeLabel: UILabel!
    
    private var presenter: PresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackSetup()
        localize()
        viewSetup()
        presenter?.load()
    }

    @IBAction func onStartButtonTap(_ sender: UIButton) {
        startButton.isHidden = true
        animationView?.backgroundColor = UIColor.cyan
        UIView.animate(withDuration: 2.0, animations: { [weak self] in
            self?.animationView?.transform = CGAffineTransform(scaleX: C.initialViewScale, y: C.initialViewScale)
            }, completion: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.presenter?.startSequence()
                strongSelf.phaseStackView.isHidden = false
                strongSelf.remainingTimeStackView.isHidden = false
        })
    }
    
}

extension ViewController: ViewProtocol {
    
    func set(phases: [Phase]) {
        loadingView.isHidden = true
        loadingView.stopAnimating()
        
    }
    
    func setLoading() {
        loadingView.isHidden = false
        loadingView.startAnimating()
    }

    func set(error: Error) {
        loadingView.isHidden = true
        loadingView.stopAnimating()
    }
    
    func onReady(sequence: PhaseSequence) {
        sequence.observer = self
        startButton.isHidden = false
        loadingView.isHidden = true
        loadingView.stopAnimating()
    }
}

private extension ViewController {
    
    struct C {
        static let initialViewScale: CGFloat = 0.75
        static let path = "phases"
        static let ext = "json"
        static let buttonTitle = "Tap here to start"
        static let remainingTitle = "Remaining"
    }
    
    func multiplier(from type:PhaseType) -> CGFloat? {
        switch type {
        case .exhale:
            return 0.5
        case .inhale:
            return 1.0
        case .hold:
            return nil
        }
    }
    
    func stackSetup() {
        let loader = Loader(path: C.path, ext: C.ext)
        let model = Model(loader: loader)
        let presenter = Presenter(model: model)
        presenter.view = self
        self.presenter = presenter
    }
    
    func localize() {
        startButton.setTitle(C.buttonTitle, for: .normal)
        remainingLabel.text = C.remainingTitle
    }
    
    func viewSetup() {
        phaseStackView.isHidden = true
        remainingTimeStackView.isHidden = true
        startButton.isHidden = true
    }
}

extension ViewController: SequenceObserver {
    
    func timeUpdated(sequence: TimeInterval, phase: TimeInterval) {
        remainingTimeLabel.text = String(sequence)
        phaseDurationLabel.text = String(phase)
    }
    
    func phaseBegan(phase: Phase) {
        phaseNameLabel.text = phase.type.rawValue.uppercased()
        animationView.backgroundColor = UIColor.init(hexFromString: phase.color)
        if let scale = multiplier(from: phase.type) {
            UIView.animate(withDuration: phase.duration) { [weak self] in
                self?.animationView?.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
    }
    
    func sequenceCompleted() {
        startButton.isHidden = false
        phaseStackView.isHidden = true
        remainingTimeStackView.isHidden = true
    }
    
    
    
}

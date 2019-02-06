//
//  ViewController.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import UIKit

final class AnimationViewController: UIViewController {

    @IBOutlet private weak var animationView: UIView!
    @IBOutlet private weak var phaseStackView: UIStackView!
    @IBOutlet private weak var phaseNameLabel: UILabel!
    @IBOutlet private weak var phaseDurationLabel: UILabel!
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    @IBOutlet private weak var remainingTimeStackView: UIStackView!
    @IBOutlet private weak var remainingLabel: UILabel!
    @IBOutlet private weak var remainingTimeLabel: UILabel!
    
    private var presenter: AnimationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackSetup()
        localize()
        viewSetup()
        presenter?.load()
    }

    @IBAction func onStartButtonTap(_ sender: UIButton) {
        startButton.isHidden = true
        animationView?.backgroundColor = .cyan
        UIView.animate(withDuration: 2.0, animations: { [weak self] in
            self?.animationView?.transform = CGAffineTransform(scaleX: Constants.initialViewScale, y: Constants.initialViewScale)
        }, completion: { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.presenter?.startSequence()
            strongSelf.phaseStackView.isHidden = false
            strongSelf.remainingTimeStackView.isHidden = false
        })
    }
}

extension AnimationViewController: AnimationViewProtocol {
    
    func set(phases: [Phase]) {
        loadingView.stopAnimating()
    }
    
    func setLoading() {
        loadingView.startAnimating()
    }

    func set(error: Error) {
        loadingView.stopAnimating()
    }
    
    func onReady(sequence: PhaseSequence) {
        sequence.observer = self
        startButton.isHidden = false
        loadingView.stopAnimating()
    }
}

private extension AnimationViewController {
    
    enum Constants {
        static let initialViewScale: CGFloat = 0.75
        static let path = "phases"
        static let ext = "json"
        static let buttonTitle = "Tap here to start"
        static let remainingTitle = "Remaining"
    }
    
    func multiplier(from type: PhaseType) -> CGFloat? {
        switch type {
        case .exhale:
            return 0.5
        case .inhale:
            return 1.0
        case .hold:
            return nil
        }
    }
    
    // Should not be configured inside of a ViewController
    func stackSetup() {
        guard let phaseListURL = Bundle.main.url(forResource: Constants.path, withExtension: Constants.ext) else {
            return
        }
        let loader = URLPhaseListLoader(url: phaseListURL, decoding: .json(), queue: .global())
        let model = AnimationModel(loader: loader)
        let presenter = AnimationPresenter(model: model)
        presenter.view = self
        self.presenter = presenter
    }
    
    func localize() {
        startButton.setTitle(Constants.buttonTitle, for: .normal)
        remainingLabel.text = Constants.remainingTitle
    }
    
    func viewSetup() {
        phaseStackView.isHidden = true
        remainingTimeStackView.isHidden = true
        startButton.isHidden = true
    }
}

extension AnimationViewController: PhaseSequenceObserver {
    
    func remainingTimeDidChange(currentPhase: TimeInterval, total: TimeInterval) {
        remainingTimeLabel.text = total.stringFormatted()
        phaseDurationLabel.text = currentPhase.stringFormatted()
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

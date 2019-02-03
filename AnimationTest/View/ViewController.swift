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
        presenter?.load()
    }

    @IBAction func onStartButtonTap(_ sender: UIButton) {
        
    }
    
}

extension ViewController: ViewProtocol {
    
    func set(phases: [Phase]) {
        
    }

}

private extension ViewController {
    
    struct C {
        static let path = "phases"
        static let ext = "json"
    }
    
    func stackSetup() {
        let loader = Loader(path: C.path, ext: C.ext)
        let model = Model(loader: loader)
        let presenter = Presenter(model: model)
        presenter.view = self
        self.presenter = presenter
    }
    
}


//
//  ViewController.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    private var presenter: PresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackSetup()
    }


}

extension ViewController: ViewProtocol {
    
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


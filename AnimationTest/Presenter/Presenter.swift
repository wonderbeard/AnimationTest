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
    }
}

extension Presenter: PresenterProtocol {
    
}

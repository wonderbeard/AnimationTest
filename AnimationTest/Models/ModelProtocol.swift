//
//  ModelProtocol.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

typealias AnimationModelStatus = ModelStatus<[Phase]>

protocol ModelProtocol: class {
    var output: ModelOutput? { get set }
    func load()
}

protocol ModelOutput: class {
    func didUpdate(status: AnimationModelStatus)
}

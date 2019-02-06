//
//  ModelProtocol.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

typealias AnimationModelStatus = ResourceRetrievalStatus<[Phase]>

protocol AnimationModelProtocol: class {
    var output: AnimationModelOutput? { get set }
    func load()
    func reload()
}

protocol AnimationModelOutput: class {
    func didUpdate(status: AnimationModelStatus)
}

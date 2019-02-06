//
//  ViewProtocol.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

protocol AnimationViewProtocol: class {
    func set(phases: [Phase])
    func setLoading()
    func set(error: Error)
    func onReady(sequence: PhaseSequence)
}

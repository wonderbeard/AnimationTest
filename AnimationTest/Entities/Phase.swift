//
//  Phase.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

struct Phase: Codable {
    let type: PhaseType
    let duration: Double
    let color: String
}

enum PhaseType: String, Codable {
    case inhale
    case exhale
    case hold
}

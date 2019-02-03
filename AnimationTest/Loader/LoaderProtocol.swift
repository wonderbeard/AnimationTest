//
//  LoaderProtocol.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

protocol LoaderProtocol: class {
    func load(completion: @escaping (Try<[Phase]>) -> ())
}

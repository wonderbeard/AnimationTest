//
//  Loader.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation

final class Loader {
    private let path: String
    private let ext: String
    
    init (path: String, ext: String) {
        self.path = path
        self.ext = ext
    }
}

extension Loader: LoaderProtocol {
    
    func load(completion: @escaping (Try<[Phase]>) -> ()) {
        DispatchQueue.global().async { [weak self] in
            guard
                let strongSelf = self,
                let jsonURL = Bundle.main.url(forResource: strongSelf.path, withExtension: strongSelf.ext)
                else {
                    async(completion(.failure(GenericError.fileNotFound)))
                    return
            }
            do {
                let jsonData = try Data(contentsOf: jsonURL)
                let decoder = JSONDecoder()
                do {
                    let animation = try decoder.decode([Phase].self, from: jsonData)
                    async(completion(.success(animation)))
                } catch {
                    async(completion(.failure(GenericError.notLoaded)))
                }
            } catch {
                async(completion(.failure(GenericError.notLoaded)))
            }
        }
    }
}

private func async(_ block: @autoclosure @escaping () -> ()) {
    DispatchQueue.main.async(execute: block)
}


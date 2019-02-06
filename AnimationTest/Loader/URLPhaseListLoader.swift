//
//  Loader.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation

final class URLPhaseListLoader {
    
    private let url: URL
    private let queue: DispatchQueue
    private let decoding: Decoding<Data, [Phase]>
    
    init(url: URL, decoding: Decoding<Data, [Phase]>, queue: DispatchQueue) {
        self.url = url
        self.decoding = decoding
        self.queue = queue
    }
}

extension URLPhaseListLoader: PhaseListLoaderProtocol {
    
    func load(completion: @escaping (Result<[Phase]>) -> Void) {
        queue.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            do {
                let jsonData = try Data(contentsOf: strongSelf.url)
                let phases = try strongSelf.decoding.decode(jsonData)
                completion(.success(phases))
            } catch {
                completion(.failure(GenericError.notLoaded))
            }
        }
    }
}

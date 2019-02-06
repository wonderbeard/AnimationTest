//
//  Decoding.swift
//  AnimationTest
//
//  Created by Andrey Malyarchuk on 2/6/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation

struct Decoding<Source, Destination> {
    let decode: (Source) throws -> Destination
}

extension Decoding where Destination: Decodable {
    
    static func json(using decoder: JSONDecoder = .init()) -> Decoding<Data, Destination> {
        return Decoding<Data, Destination> { data in
            try decoder.decode(Destination.self, from: data)
        }
    }
}

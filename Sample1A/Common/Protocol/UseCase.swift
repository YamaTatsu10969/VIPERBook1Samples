//
//  UseCase.swift
//  Sample1A
//
//  Created by Yoshinori Imajo on 2019/11/24.
//  Copyright © 2019 Yoshinori Imajo. All rights reserved.
//

import Foundation

protocol UseCase {
    associatedtype Input
    associatedtype Success

    func execute(input: Input, completion: ((Result<Success, Error>) -> ())?)
}

class AnyUseCaseBox<Input, Success> {
    func execute(input: Input, completion: ((Result<Success, Error>) -> ())?) {
        fatalError()
    }
}

final class UseCaseBox<T: UseCase>: AnyUseCaseBox<T.Input, T.Success> {
    private let base: T

    init(_ base: T) {
        self.base = base
    }

    override func execute(input: T.Input, completion: ((Result<T.Success, Error>) -> ())?) {
        base.execute(input: input, completion: completion)
    }
}

final class AnyUseCase<Input, Success>: UseCase {
    private let box: AnyUseCaseBox<Input, Success>

    init<T: UseCase>(_ base: T) where T.Input == Input, T.Success == Success {
        box = UseCaseBox<T>(base)
    }

    func execute(input: Input, completion: ((Result<Success, Error>) -> ())?) {
        box.execute(input: input, completion: completion)
    }
    }
}

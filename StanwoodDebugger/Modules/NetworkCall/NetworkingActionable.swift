//
//  NetworkingActionable.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//


protocol NetworkingActionable {
    func present(data: NetworkData)
}

extension DebuggerActions: NetworkingActionable {
    func present(data: NetworkData) {
        coordinator?.present(data)
    }
}

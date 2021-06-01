//
//  ViewStateProtocol.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 01.06.2021.
//

import Foundation

protocol ViewStates {}

protocol ViewStateProtocol {
    associatedtype States: ViewStates
    
    var viewState: States { get set }
    
    // check state after initiating view or viewmodel values
    // and configure
    func checkState()
}

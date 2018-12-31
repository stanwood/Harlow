//
//  ErrorDetailItems.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 31/12/2018.
//

import Foundation
import StanwoodCore

class ErrorDetailISections: Stanwood.Sections {}

class ErrorOverviewSection: Stanwood.Elements<ErrorItem>, Headerable {
    
    var headerView: UIView {
        let view = NetworkHeaderView.loadFromNib(bundle: Bundle.debuggerBundle())
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: "OVERVIEW")
        return view ?? UIView()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return ErrorOverviewCell.self
    }
}

class ErrorCodeSection: Stanwood.Elements<ErrorItem>, Headerable {
    
    var headerView: UIView {
        let view = NetworkHeaderView.loadFromNib(bundle: Bundle.debuggerBundle())
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: "CODE")
        return view ?? UIView()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return ErrorCodeCell.self
    }
}

class ErrorUserInfoSection: Stanwood.Elements<ErrorItem>, Headerable {
    
    var headerView: UIView {
        let view = NetworkHeaderView.loadFromNib(bundle: Bundle.debuggerBundle())
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: "USER INFO")
        return view ?? UIView()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return ErrorUserInfoCell.self
    }
}

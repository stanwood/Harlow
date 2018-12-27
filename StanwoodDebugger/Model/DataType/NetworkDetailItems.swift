//
//  NetworkDetailItems.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 25/12/2018.
//

import Foundation
import StanwoodCore

class NetworkDetailISections: Stanwood.Sections {}

class NetworkLatencySection: Stanwood.Elements<NetworkItem>, Headerable {
    
    var headerView: UIView {
        let view = NetworkHeaderView.loadFromNib(bundle: Bundle.debuggerBundle())
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: "LATENCY")
        return view ?? UIView()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return NetworkLatencyCell.self
    }
}

class NetworkErrorSection: Stanwood.Elements<NetworkItem>, Headerable {
    
    var headerView: UIView {
        let view = NetworkHeaderView.loadFromNib(bundle: Bundle.debuggerBundle())
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: "ERROR")
        return view ?? UIView()
    }
    
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return NetworkErrorCell.self
    }
}

class NetworkOverviewSection: Stanwood.Elements<NetworkItem>, Headerable {
    
    var headerView: UIView {
        let view = NetworkHeaderView.loadFromNib(bundle: Bundle.debuggerBundle())
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: "CALL OVERVIEW")
        return view ?? UIView()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return NetworkOverviewCell.self
    }
}

class NetworkResponseSection: Stanwood.Elements<NetworkItem>, Headerable {
    
    var headerView: UIView {
        let view = NetworkHeaderView.loadFromNib(bundle: Bundle.debuggerBundle())
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: "RESPONSE")
        return view ?? UIView()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return NetworkResponseCell.self
    }
}

class NetworkHeadersSection: Stanwood.Elements<NetworkItem>, Headerable {
    
    var headerView: UIView {
        let view = NetworkHeaderView.loadFromNib(bundle: Bundle.debuggerBundle())
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: "HEADERS")
        return view ?? UIView()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return NetworkHeadersCell.self
    }
}

class NetworkDataSection: Stanwood.Elements<NetworkItem>, Headerable {
    
    var headerView: UIView {
        let view = NetworkHeaderView.loadFromNib(bundle: Bundle.debuggerBundle())
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: "DATA RESPONSE")
        return view ?? UIView()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return NetworkDataResponseCell.self
    }
}

class NetworkBodySection: Stanwood.Elements<NetworkItem>, Headerable {
    
    var headerView: UIView {
        let view = NetworkHeaderView.loadFromNib(bundle: Bundle.debuggerBundle())
        view?.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view?.set(title: "DATA BODY")
        return view ?? UIView()
    }
    
    override func cellType(forItemAt indexPath: IndexPath) -> Fillable.Type? {
        return NetworkDataBodyCell.self
    }
}

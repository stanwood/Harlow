//
//  DebuggerSettings.swift
//  Pods-StanwoodDebugger_Example
//
//  Created by Tal Zion on 25/04/2018.
//

import Foundation

class SettingsViewController: UIViewController {
    
    var presenter: SettingsPresenter!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: view.bounds.width, height: 44)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: statusBarHeight + navigationBarHeight, width: view.bounds.width, height: view.bounds.height - ([statusBarHeight, navigationBarHeight, tabBarHeight].reduce(0, +))), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.addSubview(collectionView)

        let nib = UINib(nibName: SettingsCell.identifier, bundle: Bundle.debuggerBundle())
        let headerNib = UINib(nibName: SettingsHeaderView.identifier, bundle: Bundle.debuggerBundle())
        
        collectionView.register(nib, forCellWithReuseIdentifier: SettingsCell.identifier)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SettingsHeaderView.identifier)
        
        collectionView.set(spacing: 0)
        
        collectionView.dataSource = presenter.dataSource
        collectionView.delegate = presenter.delegate
    }
    
    @objc func dismissDebuggerView() {
        tabBarController?.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: SettingsViewable {
    
}

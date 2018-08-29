//
//  SettingsDelegate.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 02/08/2018.
//

import Foundation
import StanwoodCore

class SettingsDelegate: Stanwood.AbstractCollectionDelegate {
    
    weak var presenter: SettingsPresenter?
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 56.0)
    }
}

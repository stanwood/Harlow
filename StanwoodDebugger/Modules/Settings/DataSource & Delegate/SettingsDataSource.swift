//
//  SettingsDataSource.swift
//  StanwoodDebugger
//
//  Created by Tal Zion on 02/08/2018.
//

import Foundation
import StanwoodCore

class SettingsDataSource: Stanwood.AbstractCollectionDataSource {
    
    weak var presenter: SettingsPresenter?
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! SettingsCell
        cell.delegate = self
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueHeader(cellType: SettingsHeaderView.self, for: indexPath)
        if let section = dataObject?[indexPath.section] as? SettingsData.Section {
            header.set(title: section.title)
        }
        return header
    }
}

extension SettingsDataSource: SettingsCellDelegate {
    func switchDidChange(to value: Bool, for type: SettingsData.Section.SettingType) {
        presenter?.switchDidChange(to: value, for: type)
    }
    
    func didTapAction(_ type: SettingsData.Section.SettingType) {
        presenter?.didTapAction(type)
    }
}

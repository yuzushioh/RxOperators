//
//  RxCollectionViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/4/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let viewModel = TimelineViewModel()
    private let disposeBag = DisposeBag()
    
    override var collectionView: UICollectionView! {
        get {
            return super.collectionView
        }
        
        set {
            super.collectionView = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindCollectionView()
    }
    
    private func bindCollectionView() {
        viewModel.elements
            .bindTo(collectionView.rx_itemsWithCellIdentifier("Cell", cellType: TimelineCollectionViewCell.self)) { index, timeline, cell in
                cell.timeline = timeline
            }
            .addDisposableTo(disposeBag)
        
        collectionView.rx_modelSelected(Timeline)
            .subscribeNext { [weak self] timeline in
                Alert.showAlert("Selected House", message: timeline.title, baseViewController: self)
            }
            .addDisposableTo(disposeBag)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (collectionView.frame.width - 1.0)/2
        return CGSize(width: width, height: width)
    }
}

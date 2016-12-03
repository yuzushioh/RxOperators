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
    
    fileprivate let viewModel = TimelineViewModel()
    fileprivate let disposeBag = DisposeBag()
    
    override var collectionView: UICollectionView! {
        get { return super.collectionView }
        set { super.collectionView = newValue }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindCollectionView()
    }
    
    fileprivate func bindCollectionView() {
        viewModel.elements
            .bindTo(collectionView.rx.items(cellIdentifier: "Cell", cellType: TimelineCollectionViewCell.self)) { index, timeline, cell in
                cell.timeline = timeline
            }
            .addDisposableTo(disposeBag)
        
        collectionView.rx.modelSelected(Timeline.self)
            .subscribe(onNext: { [weak self] timeline in
                Alert.showAlert("Selected House", message: timeline.title, baseViewController: self)
            })
            .addDisposableTo(disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 1.0)/2
        return CGSize(width: width, height: width)
    }
}

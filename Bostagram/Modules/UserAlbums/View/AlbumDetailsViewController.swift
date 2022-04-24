//
//  AlbumDetailsViewController.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumDetailsViewController: BaseViewController {

    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var photosCollectionView: UICollectionView!

    private let disposeBag = DisposeBag()

    var viewModel: AlbumDetailsViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad.onNext(())
    }

    private func setupUI() {
        setupNavigationBarTitle()
        bindSearchBar()
        bindPhotosCollectionView()
    }

    private func setupNavigationBarTitle() {
        setViewTitleMode(isLarge: true)
        viewModel.album.bind { [weak self] album in
            self?.title = album.title
        }
        .disposed(by: disposeBag)
    }

    private func bindSearchBar() {
        searchBar.placeholder = "albumDetails_search_placeholder".localized()
        searchBar.rx
            .text
            .orEmpty
            .debounce(.milliseconds(5), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(viewModel.searchPhotos)
            .disposed(by: disposeBag)
    }

    private func bindPhotosCollectionView() {
        setupCollectionViewFlow()
        setupCollectionViewItemSelection()
        setupCellForItems()
    }

    private func setupCellForItems() {
        viewModel.filterPhotos
            .bind(to: photosCollectionView.rx.items(cellIdentifier: "PhotoCell",
                                               cellType: PhotoCollectionViewCell.self)) { _, element, cell in
                cell.bind(with: element.url)
            }.disposed(by: disposeBag)
    }

    private func setupCollectionViewFlow() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 3
        let size = (photosCollectionView.bounds.width - CGFloat(30)) / CGFloat(3)
        flowLayout.itemSize = CGSize(width: size, height: size)
        photosCollectionView.setCollectionViewLayout(flowLayout, animated: true)
    }

    private func setupCollectionViewItemSelection() {
        photosCollectionView.rx.itemSelected
            .map({ $0.row })
            .bind(to: viewModel.selectPhoto)
            .disposed(by: disposeBag)
        setupCollectionViewFlow()
    }
}

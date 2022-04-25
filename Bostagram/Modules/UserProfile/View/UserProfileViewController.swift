//
//  UserProfileViewController.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import UIKit
import RxSwift
import RxCocoa

class UserProfileViewController: BaseViewController {

    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var addressLabel: UILabel!
    @IBOutlet weak private var myAlbumsTitleLabel: UILabel!
    @IBOutlet weak private var albumsTableView: UITableView!

    private let disposeBag = DisposeBag()

    var viewModel: UserProfileViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingView()
        viewModel.viewDidLoad.onNext(())
        setupUI()
    }

    private func setupUI() {
        setupNavigationBarTitle()
        setupMyAlbumTitleLabel()
        bindUserNameLabel()
        bindAddressLabel()
        bindAlbumsTableView()
    }

    private func setupNavigationBarTitle() {
        title = "userProfile_title".localized()
        setViewTitleMode(isLarge: true)
    }

    private func setupMyAlbumTitleLabel() {
        myAlbumsTitleLabel.text = "userProfile_my_album_title".localized()
    }

    private func bindUserNameLabel() {
        viewModel.user
            .map({ $0.name })
            .bind(to: userNameLabel.rx.text)
            .disposed(by: disposeBag)
    }

    private func bindAddressLabel() {
        viewModel.user
            .map({ user in
                let address = user.address
                return "\(address.street), \(address.apt), \(address.city)\n\(address.zipCode)"
            })
            .bind(to: addressLabel.rx.text)
            .disposed(by: disposeBag)
    }

    private func bindAlbumsTableView() {
        setupCellForItems()
        setupTableViewSelectItem()
    }

    private func setupCellForItems() {
        viewModel.albums
            .do(afterCompleted: { [weak self] in
                self?.hideLoadingView(completion: {})
            })
            .bind(to: albumsTableView.rx.items(cellIdentifier: "AlbumCell",
                                               cellType: UITableViewCell.self)) { _, element, cell in
                cell.textLabel?.text = element.title
                cell.textLabel?.numberOfLines = 0
                cell.selectionStyle = .none
            }.disposed(by: disposeBag)
    }

    private func setupTableViewSelectItem() {
        albumsTableView.rx.itemSelected
            .map({ $0.row })
            .bind(to: viewModel.selectAlbum)
            .disposed(by: disposeBag)
    }
}

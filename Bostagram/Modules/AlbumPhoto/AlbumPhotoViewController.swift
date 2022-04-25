//
//  AlbumPhotoViewController.swift
//  Bostagram
//
//  Created by Samir on 4/25/22.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift

class AlbumPhotoViewController: BaseViewController {

    @IBOutlet weak private var webView: WKWebView!

    private let disposeBag = DisposeBag()

    var viewModel: AlbumPhotoViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarTitle()
        addShareButton()
        bindView()
        viewModel.viewDidLoad.onNext(())
    }

    private func setupNavigationBarTitle() {
        setViewTitleMode(isLarge: true)
        viewModel.photo.bind { [weak self] photo in
            self?.title = photo.title
        }
        .disposed(by: disposeBag)
    }

    private func addShareButton() {
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                          style: .plain,
                                          target: nil,
                                          action: nil)
        navigationItem.rightBarButtonItem = shareButton
        shareButton.rx
            .tap
            .withLatestFrom(viewModel.photo)
            .bind { [weak self] photo in
                self?.sharePhoto(photo)
            }
            .disposed(by: disposeBag)
    }

    private func bindView() {
        viewModel.photo.bind { [weak self] photo in
            self?.loadImage(with: photo.url)
        }
        .disposed(by: disposeBag)
    }

    private func loadImage(with url: String) {
        guard let url = URL(string: url) else { return }
        webView.load(URLRequest(url: url))
    }

    private func sharePhoto(_ photo: Photo) {
        let activityController = UIActivityViewController(activityItems: [photo.title, photo.url],
                                                          applicationActivities: nil)
        present(activityController, animated: true)
    }

}

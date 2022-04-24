//
//  StoryboardInstantiable.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import UIKit

protocol StoryboardInstantiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardInstantiable where Self: UIViewController {

    static var storyboardIdentifier: String {
        return String(describing: self)
    }

    static func instantiate(from storyboard: UIStoryboard.Storyboard) -> Self {
        return UIStoryboard(storyboard: storyboard).instantiateViewController()
    }
}

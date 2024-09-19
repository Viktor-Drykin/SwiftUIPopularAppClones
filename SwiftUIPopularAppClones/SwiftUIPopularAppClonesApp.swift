//
//  SwiftUIPopularAppClonesApp.swift
//  SwiftUIPopularAppClones
//
//  Created by Viktor Drykin on 19.09.2024.
//

import SwiftUI

import SwiftUI
import SwiftfulRouting

@main
struct SwiftUIPopularAppClonesApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecogniserShouldBegin(_ gestureRecogniser: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}


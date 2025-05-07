//
//  BackgroundViewModel.swift
//  gabies-gallery
//
//  Created by Farrell Matthew Lim on 07/05/25.
//

import GameplayKit
import SwiftUI

final class BackgroundViewModel: ObservableObject {
    func getSafeAreaBottomInset() -> CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first(where: {
            $0 is UIWindowScene
        }) as? UIWindowScene {
            return windowScene.windows.first?.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
}

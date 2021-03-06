//
//  Vibrations.swift
//  Kris
//
//  Created by Kristopher Jackson on 4/7/20.
//  Copyright © 2020 Kristopher Jackson. All rights reserved.
//

import UIKit
import AVFoundation

enum Vibration {
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    case selection
    case oldSchool

    func vibrate() {

      switch self {
      case .error:
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)

      case .success:
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)

      case .warning:
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)

      case .light:
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

      case .medium:
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

      case .heavy:
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()

      case .selection:
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()

      case .oldSchool:
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
      }

    }
}

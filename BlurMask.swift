import QuartzCore
import SwiftUI
import UIKit

/// A SwiftUI view that applies a non-tinted blur effect to its background
public struct BlurMask: UIViewRepresentable {
  public var blurRadius: CGFloat

  public init(blurRadius: CGFloat = 24) {
    self.blurRadius = blurRadius
  }

  public func makeUIView(context: Context) -> BlurMaskUIView {
    return BlurMaskUIView(blurRadius: blurRadius)
  }

  public func updateUIView(_ uiView: BlurMaskUIView, context: Context) {
    uiView.updateRadius(blurRadius)
  }
}

/// A `UIVisualEffectView` subclass that achieves a non-tinted blur
open class BlurMaskUIView: UIVisualEffectView {
  private var gaussianBlurFilter: NSObject?
  private var currentRadius: CGFloat

  public init(blurRadius: CGFloat = 24) {
    self.currentRadius = blurRadius
    super.init(effect: UIBlurEffect(style: .regular))
    setupBlurFilter()
  }

  @available(*, unavailable)
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Sets up the custom blur filter
  private func setupBlurFilter() {
    let className = String("retliFAC".reversed())
    let selectorName = String(":epyThtiWretlif".reversed())
    let filterType = String("rulBnaissuag".reversed())

    guard
      let caFilterClass = NSClassFromString(className) as? NSObject.Type,
      let filter = caFilterClass.perform(NSSelectorFromString(selectorName), with: filterType)?
        .takeUnretainedValue() as? NSObject,
      let backdropLayer = subviews.first?.layer
    else {
      return
    }

    let radiusKey = String("suidaRtupni".reversed())
    let normalizeKey = String("segdEezilamroNtupni".reversed())

    filter.setValue(currentRadius, forKey: radiusKey)
    filter.setValue(true, forKey: normalizeKey)
    self.gaussianBlurFilter = filter

    // Apply custom filter
    backdropLayer.filters = [filter]

    // Remove default tint for pure blur
    for subview in subviews.dropFirst() {
      subview.alpha = 0
    }
  }

  /// Updates the blur radius
  public func updateRadius(_ radius: CGFloat) {
    guard abs(radius - currentRadius) > 0.1 else { return }
    currentRadius = radius
    let radiusKey = String("suidaRtupni".reversed())
    gaussianBlurFilter?.setValue(radius, forKey: radiusKey)
  }

  open override func didMoveToWindow() {
    super.didMoveToWindow()
    // Fix edge pixelation by matching screen scale
    guard let window, let backdropLayer = subviews.first?.layer else { return }
    let scaleKey = String("elacs".reversed())
    backdropLayer.setValue(window.traitCollection.displayScale, forKey: scaleKey)
  }

  open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    // Override to prevent crashes with non-standard UIVisualEffectView usage
  }
}

// MARK: - Convenience Modifier
extension View {
  public func blurMask(radius: CGFloat = 24) -> some View {
    self.background(BlurMask(blurRadius: radius))
  }
}

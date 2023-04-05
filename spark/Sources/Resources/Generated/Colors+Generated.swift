// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum SparkColorAsset {
  public static let primary = ColorAsset(name: "Primary")
  public static let secondary = ColorAsset(name: "Secondary")
  public static let badgeBackgroundColor = ColorAsset(name: "badgeBackgroundColor")
  public static let badgeColor = ColorAsset(name: "badgeColor")
  public static let badgeVariantAlertBackgroundColor = ColorAsset(name: "badgeVariantAlertBackgroundColor")
  public static let badgeVariantAlertColor = ColorAsset(name: "badgeVariantAlertColor")
  public static let badgeVariantErrorBackgroundColor = ColorAsset(name: "badgeVariantErrorBackgroundColor")
  public static let badgeVariantErrorColor = ColorAsset(name: "badgeVariantErrorColor")
  public static let badgeVariantSuccessBackgroundColor = ColorAsset(name: "badgeVariantSuccessBackgroundColor")
  public static let badgeVariantSuccessColor = ColorAsset(name: "badgeVariantSuccessColor")
  public static let brandAlert = ColorAsset(name: "brandAlert")
  public static let brandAlertContainer = ColorAsset(name: "brandAlertContainer")
  public static let brandBackground = ColorAsset(name: "brandBackground")
  public static let brandBackgroundVariant = ColorAsset(name: "brandBackgroundVariant")
  public static let brandError = ColorAsset(name: "brandError")
  public static let brandErrorContainer = ColorAsset(name: "brandErrorContainer")
  public static let brandInfo = ColorAsset(name: "brandInfo")
  public static let brandInfoContainer = ColorAsset(name: "brandInfoContainer")
  public static let brandNeutral = ColorAsset(name: "brandNeutral")
  public static let brandNeutralContainer = ColorAsset(name: "brandNeutralContainer")
  public static let brandOnAlert = ColorAsset(name: "brandOnAlert")
  public static let brandOnAlertContainer = ColorAsset(name: "brandOnAlertContainer")
  public static let brandOnBackground = ColorAsset(name: "brandOnBackground")
  public static let brandOnBackgroundVariant = ColorAsset(name: "brandOnBackgroundVariant")
  public static let brandOnError = ColorAsset(name: "brandOnError")
  public static let brandOnErrorContainer = ColorAsset(name: "brandOnErrorContainer")
  public static let brandOnInfo = ColorAsset(name: "brandOnInfo")
  public static let brandOnInfoContainer = ColorAsset(name: "brandOnInfoContainer")
  public static let brandOnNeutral = ColorAsset(name: "brandOnNeutral")
  public static let brandOnNeutralContainer = ColorAsset(name: "brandOnNeutralContainer")
  public static let brandOnPrimary = ColorAsset(name: "brandOnPrimary")
  public static let brandOnPrimaryContainer = ColorAsset(name: "brandOnPrimaryContainer")
  public static let brandOnPrimaryVariant = ColorAsset(name: "brandOnPrimaryVariant")
  public static let brandOnSecondary = ColorAsset(name: "brandOnSecondary")
  public static let brandOnSecondaryContainer = ColorAsset(name: "brandOnSecondaryContainer")
  public static let brandOnSecondaryVariant = ColorAsset(name: "brandOnSecondaryVariant")
  public static let brandOnSuccess = ColorAsset(name: "brandOnSuccess")
  public static let brandOnSuccessContainer = ColorAsset(name: "brandOnSuccessContainer")
  public static let brandOnSurface = ColorAsset(name: "brandOnSurface")
  public static let brandOnSurfaceInverse = ColorAsset(name: "brandOnSurfaceInverse")
  public static let brandOutline = ColorAsset(name: "brandOutline")
  public static let brandOutlineHigh = ColorAsset(name: "brandOutlineHigh")
  public static let brandPrimary = ColorAsset(name: "brandPrimary")
  public static let brandPrimaryContainer = ColorAsset(name: "brandPrimaryContainer")
  public static let brandPrimaryVariant = ColorAsset(name: "brandPrimaryVariant")
  public static let brandSecondary = ColorAsset(name: "brandSecondary")
  public static let brandSecondaryContainer = ColorAsset(name: "brandSecondaryContainer")
  public static let brandSecondaryVariant = ColorAsset(name: "brandSecondaryVariant")
  public static let brandSuccess = ColorAsset(name: "brandSuccess")
  public static let brandSuccessContainer = ColorAsset(name: "brandSuccessContainer")
  public static let brandSurface = ColorAsset(name: "brandSurface")
  public static let brandSurfaceInverse = ColorAsset(name: "brandSurfaceInverse")
  public static let buttonColor = ColorAsset(name: "buttonColor")
  public static let buttonPrimaryActiveBackgroundColor = ColorAsset(name: "buttonPrimaryActiveBackgroundColor")
  public static let buttonPrimaryActiveColor = ColorAsset(name: "buttonPrimaryActiveColor")
  public static let buttonPrimaryBackgroundColor = ColorAsset(name: "buttonPrimaryBackgroundColor")
  public static let buttonPrimaryColor = ColorAsset(name: "buttonPrimaryColor")
  public static let buttonPrimaryHoverBackgroundColor = ColorAsset(name: "buttonPrimaryHoverBackgroundColor")
  public static let buttonPrimaryHoverColor = ColorAsset(name: "buttonPrimaryHoverColor")
  public static let buttonSecondaryActiveBackgroundColor = ColorAsset(name: "buttonSecondaryActiveBackgroundColor")
  public static let buttonSecondaryActiveBorderColor = ColorAsset(name: "buttonSecondaryActiveBorderColor")
  public static let buttonSecondaryActiveColor = ColorAsset(name: "buttonSecondaryActiveColor")
  public static let buttonSecondaryBackgroundColor = ColorAsset(name: "buttonSecondaryBackgroundColor")
  public static let buttonSecondaryBorderColor = ColorAsset(name: "buttonSecondaryBorderColor")
  public static let buttonSecondaryColor = ColorAsset(name: "buttonSecondaryColor")
  public static let buttonSecondaryHoverBorderColor = ColorAsset(name: "buttonSecondaryHoverBorderColor")
  public static let buttonSecondaryHoverColor = ColorAsset(name: "buttonSecondaryHoverColor")
  public static let coreApple100 = ColorAsset(name: "coreApple100")
  public static let coreApple200 = ColorAsset(name: "coreApple200")
  public static let coreApple300 = ColorAsset(name: "coreApple300")
  public static let coreApple400 = ColorAsset(name: "coreApple400")
  public static let coreApple50 = ColorAsset(name: "coreApple50")
  public static let coreApple500 = ColorAsset(name: "coreApple500")
  public static let coreApple600 = ColorAsset(name: "coreApple600")
  public static let coreApple700 = ColorAsset(name: "coreApple700")
  public static let coreApple800 = ColorAsset(name: "coreApple800")
  public static let coreApple900 = ColorAsset(name: "coreApple900")
  public static let coreBlack = ColorAsset(name: "coreBlack")
  public static let coreChili100 = ColorAsset(name: "coreChili100")
  public static let coreChili200 = ColorAsset(name: "coreChili200")
  public static let coreChili300 = ColorAsset(name: "coreChili300")
  public static let coreChili400 = ColorAsset(name: "coreChili400")
  public static let coreChili50 = ColorAsset(name: "coreChili50")
  public static let coreChili500 = ColorAsset(name: "coreChili500")
  public static let coreChili600 = ColorAsset(name: "coreChili600")
  public static let coreChili700 = ColorAsset(name: "coreChili700")
  public static let coreChili800 = ColorAsset(name: "coreChili800")
  public static let coreChili900 = ColorAsset(name: "coreChili900")
  public static let coreKiwi100 = ColorAsset(name: "coreKiwi100")
  public static let coreKiwi200 = ColorAsset(name: "coreKiwi200")
  public static let coreKiwi300 = ColorAsset(name: "coreKiwi300")
  public static let coreKiwi400 = ColorAsset(name: "coreKiwi400")
  public static let coreKiwi50 = ColorAsset(name: "coreKiwi50")
  public static let coreKiwi500 = ColorAsset(name: "coreKiwi500")
  public static let coreKiwi600 = ColorAsset(name: "coreKiwi600")
  public static let coreKiwi700 = ColorAsset(name: "coreKiwi700")
  public static let coreKiwi800 = ColorAsset(name: "coreKiwi800")
  public static let coreKiwi900 = ColorAsset(name: "coreKiwi900")
  public static let coreSky100 = ColorAsset(name: "coreSky100")
  public static let coreSky200 = ColorAsset(name: "coreSky200")
  public static let coreSky300 = ColorAsset(name: "coreSky300")
  public static let coreSky400 = ColorAsset(name: "coreSky400")
  public static let coreSky50 = ColorAsset(name: "coreSky50")
  public static let coreSky500 = ColorAsset(name: "coreSky500")
  public static let coreSky600 = ColorAsset(name: "coreSky600")
  public static let coreSky700 = ColorAsset(name: "coreSky700")
  public static let coreSky800 = ColorAsset(name: "coreSky800")
  public static let coreSky900 = ColorAsset(name: "coreSky900")
  public static let coreSocialFacebook = ColorAsset(name: "coreSocialFacebook")
  public static let coreSocialInstagram = ColorAsset(name: "coreSocialInstagram")
  public static let coreSocialTelegram = ColorAsset(name: "coreSocialTelegram")
  public static let coreSocialTiktok = ColorAsset(name: "coreSocialTiktok")
  public static let coreSocialTwitter = ColorAsset(name: "coreSocialTwitter")
  public static let coreSocialWhatsapp = ColorAsset(name: "coreSocialWhatsapp")
  public static let coreSocialYoutube = ColorAsset(name: "coreSocialYoutube")
  public static let coreSugarcotton100 = ColorAsset(name: "coreSugarcotton100")
  public static let coreSugarcotton200 = ColorAsset(name: "coreSugarcotton200")
  public static let coreSugarcotton300 = ColorAsset(name: "coreSugarcotton300")
  public static let coreSugarcotton400 = ColorAsset(name: "coreSugarcotton400")
  public static let coreSugarcotton50 = ColorAsset(name: "coreSugarcotton50")
  public static let coreSugarcotton500 = ColorAsset(name: "coreSugarcotton500")
  public static let coreSugarcotton600 = ColorAsset(name: "coreSugarcotton600")
  public static let coreSugarcotton700 = ColorAsset(name: "coreSugarcotton700")
  public static let coreSugarcotton800 = ColorAsset(name: "coreSugarcotton800")
  public static let coreSugarcotton900 = ColorAsset(name: "coreSugarcotton900")
  public static let coreSurfer100 = ColorAsset(name: "coreSurfer100")
  public static let coreSurfer200 = ColorAsset(name: "coreSurfer200")
  public static let coreSurfer300 = ColorAsset(name: "coreSurfer300")
  public static let coreSurfer400 = ColorAsset(name: "coreSurfer400")
  public static let coreSurfer50 = ColorAsset(name: "coreSurfer50")
  public static let coreSurfer500 = ColorAsset(name: "coreSurfer500")
  public static let coreSurfer600 = ColorAsset(name: "coreSurfer600")
  public static let coreSurfer700 = ColorAsset(name: "coreSurfer700")
  public static let coreSurfer800 = ColorAsset(name: "coreSurfer800")
  public static let coreSurfer900 = ColorAsset(name: "coreSurfer900")
  public static let coreTheblue100 = ColorAsset(name: "coreTheblue100")
  public static let coreTheblue200 = ColorAsset(name: "coreTheblue200")
  public static let coreTheblue300 = ColorAsset(name: "coreTheblue300")
  public static let coreTheblue400 = ColorAsset(name: "coreTheblue400")
  public static let coreTheblue50 = ColorAsset(name: "coreTheblue50")
  public static let coreTheblue500 = ColorAsset(name: "coreTheblue500")
  public static let coreTheblue600 = ColorAsset(name: "coreTheblue600")
  public static let coreTheblue700 = ColorAsset(name: "coreTheblue700")
  public static let coreTheblue800 = ColorAsset(name: "coreTheblue800")
  public static let coreTheblue900 = ColorAsset(name: "coreTheblue900")
  public static let coreTheblueV = ColorAsset(name: "coreTheblueV")
  public static let coreWhite = ColorAsset(name: "coreWhite")
  public static let coreWiggins100 = ColorAsset(name: "coreWiggins100")
  public static let coreWiggins200 = ColorAsset(name: "coreWiggins200")
  public static let coreWiggins300 = ColorAsset(name: "coreWiggins300")
  public static let coreWiggins400 = ColorAsset(name: "coreWiggins400")
  public static let coreWiggins50 = ColorAsset(name: "coreWiggins50")
  public static let coreWiggins500 = ColorAsset(name: "coreWiggins500")
  public static let coreWiggins600 = ColorAsset(name: "coreWiggins600")
  public static let coreWiggins700 = ColorAsset(name: "coreWiggins700")
  public static let coreWiggins800 = ColorAsset(name: "coreWiggins800")
  public static let coreWiggins900 = ColorAsset(name: "coreWiggins900")
  public static let empty = ImageAsset(name: "empty")
  public static let files = ImageAsset(name: "files")
  public static let logo = ImageAsset(name: "logo")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

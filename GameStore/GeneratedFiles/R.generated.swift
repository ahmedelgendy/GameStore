//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map(Locale.init)
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 3 colors.
  struct color {
    /// Color `navigationbar-color`.
    static let navigationbarColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "navigationbar-color")
    /// Color `selected-cell`.
    static let selectedCell = Rswift.ColorResource(bundle: R.hostingBundle, name: "selected-cell")
    /// Color `tabbar-color`.
    static let tabbarColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "tabbar-color")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "navigationbar-color", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func navigationbarColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.navigationbarColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "selected-cell", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func selectedCell(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.selectedCell, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "tabbar-color", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func tabbarColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.tabbarColor, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 3 images.
  struct image {
    /// Image `close-icon`.
    static let closeIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "close-icon")
    /// Image `games-icon`.
    static let gamesIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "games-icon")
    /// Image `logo`.
    static let logo = Rswift.ImageResource(bundle: R.hostingBundle, name: "logo")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "close-icon", bundle: ..., traitCollection: ...)`
    static func closeIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.closeIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "games-icon", bundle: ..., traitCollection: ...)`
    static func gamesIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.gamesIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "logo", bundle: ..., traitCollection: ...)`
    static func logo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.logo, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 7 nibs.
  struct nib {
    /// Nib `DetailsViewController`.
    static let detailsViewController = _R.nib._DetailsViewController()
    /// Nib `FavoriteCollectionViewCell`.
    static let favoriteCollectionViewCell = _R.nib._FavoriteCollectionViewCell()
    /// Nib `FavoriteViewController`.
    static let favoriteViewController = _R.nib._FavoriteViewController()
    /// Nib `LoadingCollectionViewCell`.
    static let loadingCollectionViewCell = _R.nib._LoadingCollectionViewCell()
    /// Nib `SearchCollectionViewCell`.
    static let searchCollectionViewCell = _R.nib._SearchCollectionViewCell()
    /// Nib `SearchViewController`.
    static let searchViewController = _R.nib._SearchViewController()
    /// Nib `WebViewController`.
    static let webViewController = _R.nib._WebViewController()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "DetailsViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.detailsViewController) instead")
    static func detailsViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.detailsViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "FavoriteCollectionViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.favoriteCollectionViewCell) instead")
    static func favoriteCollectionViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.favoriteCollectionViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "FavoriteViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.favoriteViewController) instead")
    static func favoriteViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.favoriteViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "LoadingCollectionViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.loadingCollectionViewCell) instead")
    static func loadingCollectionViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.loadingCollectionViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SearchCollectionViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.searchCollectionViewCell) instead")
    static func searchCollectionViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.searchCollectionViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SearchViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.searchViewController) instead")
    static func searchViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.searchViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "WebViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.webViewController) instead")
    static func webViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.webViewController)
    }
    #endif

    static func detailsViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.detailsViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func favoriteCollectionViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> FavoriteCollectionViewCell? {
      return R.nib.favoriteCollectionViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? FavoriteCollectionViewCell
    }

    static func favoriteViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.favoriteViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func loadingCollectionViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> LoadingCollectionViewCell? {
      return R.nib.loadingCollectionViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? LoadingCollectionViewCell
    }

    static func searchCollectionViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SearchCollectionViewCell? {
      return R.nib.searchCollectionViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SearchCollectionViewCell
    }

    static func searchViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.searchViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func webViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.webViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try nib.validate()
    #endif
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _DetailsViewController.validate()
      try _WebViewController.validate()
    }

    struct _DetailsViewController: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "DetailsViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      static func validate() throws {
        if UIKit.UIImage(named: "close-icon", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'close-icon' is used in nib 'DetailsViewController', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    struct _FavoriteCollectionViewCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "FavoriteCollectionViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> FavoriteCollectionViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? FavoriteCollectionViewCell
      }

      fileprivate init() {}
    }

    struct _FavoriteViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "FavoriteViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    struct _LoadingCollectionViewCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "LoadingCollectionViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> LoadingCollectionViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? LoadingCollectionViewCell
      }

      fileprivate init() {}
    }

    struct _SearchCollectionViewCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "SearchCollectionViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SearchCollectionViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SearchCollectionViewCell
      }

      fileprivate init() {}
    }

    struct _SearchViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "SearchViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    struct _WebViewController: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "WebViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      static func validate() throws {
        if UIKit.UIImage(named: "close-icon", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'close-icon' is used in nib 'WebViewController', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if UIKit.UIImage(named: "logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'logo' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}

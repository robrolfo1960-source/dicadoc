import Flutter
import UIKit

/// SceneDelegate manuale: evita FlutterSceneDelegate (buggy su iOS 26 beta).
/// Crea il FlutterEngine e il FlutterViewController esplicitamente.
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene else { return }

    let engine = FlutterEngine(name: "main")
    engine.run()
    GeneratedPluginRegistrant.register(with: engine)

    let controller = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = controller
    window.makeKeyAndVisible()
    self.window = window
  }
}

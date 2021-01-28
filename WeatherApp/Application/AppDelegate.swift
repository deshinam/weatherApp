import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let listOfCitiesTableVC = CitiesViewController()
        let configurator = CitiesConfigurator()
        configurator.configure(viewController: listOfCitiesTableVC)
        window?.rootViewController = listOfCitiesTableVC
        window?.makeKeyAndVisible()
        
        return true
    }
}



import UIKit




extension UIViewController {
   static func createViewController (withText name: String) -> Self? {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        let identifierOfSelfClass = String(describing: self)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifierOfSelfClass) as? Self
        return viewController
}
   static func viewControllerWithStoryboardMain () -> Self? {
        createViewController(withText: "Main")
    }
    
}

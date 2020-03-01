

import UIKit

class MainViewController: UIViewController {
    
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = loadUser()
        if let user = user {
            updateUI(withUser: user)
        } else {
            userImage.image = UIImage(named: "empty")
            firstNameLabel.text = ""
            secondNameLabel.text = ""
        }
    }
    
    
    @IBAction func changeButtonDIdClick(_ sender: UIButton) {
        let changeUserViewController = ChangeUserViewController.viewControllerWithStoryboardMain()
        if let changeUserViewController = changeUserViewController {
            changeUserViewController.delegate = self
            navigationController?.pushViewController(changeUserViewController, animated: true)
        }
    }
    
    
    
}

extension MainViewController: ChangeUserViewControllerDelegate {
    func UserInfoChange(info: User) {
        updateUI(withUser: info)
        saveUser(info)
    }
    
    
}

private extension MainViewController {
    
    func updateUI(withUser user: User) {
        firstNameLabel.text = user.name
        secondNameLabel.text = user.secondName
        let image: UIImage
        switch user.sex {
        case .male:
            image = UIImage(named: "male")!
        case .female:
            image = UIImage(named: "female")!
        default:
            image = UIImage(named: "empty")!
        }
        userImage.image = image
    }
    
    
    
    func saveUser(_ user: User) {
        UserDefaults.standard.set(user.name, forKey: "user.name")
        UserDefaults.standard.set(user.secondName, forKey: "user.secondName")
        UserDefaults.standard.set(user.sex.rawValue, forKey: "user.sex")
    }
    
    func loadUser() -> User? {
        if let firstName = UserDefaults.standard.value(forKey: "user.name") as? String,
            let secondName = UserDefaults.standard.value(forKey: "user.secondName") as? String,
            let stringSex = UserDefaults.standard.value(forKey: "user.sex") as? String,
            let sex =  Sex(rawValue: stringSex ) {
    
            let user = User(name: firstName, secondName: secondName, sex: sex)
            return user
            
        }
        return nil
    }
}


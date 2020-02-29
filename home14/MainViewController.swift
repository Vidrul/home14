

import UIKit

class MainViewController: UIViewController {
    
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.image = UIImage(named: "empty")
        firstNameLabel.text = ""
        secondNameLabel.text = ""
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
        firstNameLabel.text = info.name
        secondNameLabel.text = info.secondName
        let image: UIImage
        switch info.sex {
        case .male:
            image = UIImage(named: "male")!
        case .female:
            image = UIImage(named: "female")!
        default:
            image = UIImage(named: "empty")!
        }
        userImage.image = image
    }
    
    
}

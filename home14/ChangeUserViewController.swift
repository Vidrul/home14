
import UIKit

protocol ChangeUserViewControllerDelegate: AnyObject {
    func UserInfoChange(info: User)
    
}


class ChangeUserViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var changeSex: UISegmentedControl!
    @IBOutlet weak var save: UIButton!
    
    weak var delegate: ChangeUserViewControllerDelegate?
    var sex: [Sex] = [.male,.female,.another]
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        save.alpha = 0.3
        save.isUserInteractionEnabled = false
        
        changeSex.removeAllSegments()
        for (i,gender) in sex.enumerated() {
            changeSex.insertSegment(withTitle:
                gender.description(),
                                    at: i,
                                    animated: true)
        }
        
        firstNameTextField.delegate = self
        secondNameTextField.delegate = self
    }
    
    // MARK: ActionsButton
    @IBAction func saveButtonDidClick(_ sender: UIButton) {
        errorTextField()
        let sex: Sex
        switch changeSex.selectedSegmentIndex {
        case 0:
            sex = .male
        case 1:
            sex = .female
        default:
            sex = .another
        }
        let user = User(name: firstNameTextField.text!, secondName: secondNameTextField.text!, sex: sex)
        delegate?.UserInfoChange(info: user)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func textFieldsActions(_ sender: UITextField) {
        updateSaveButton()
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        updateSaveButton()
    }
    
 
    
}

// MARK: Extension
extension ChangeUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField:
            secondNameTextField.becomeFirstResponder()
        case secondNameTextField:
            secondNameTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func updateSaveButton() {
        var isEnabled = false
        if firstNameTextField.text != nil &&
            secondNameTextField.text != nil &&
            changeSex.selectedSegmentIndex != -1 {
            isEnabled = true
        }
        if isEnabled {
            save.alpha = 1.0
            save.isUserInteractionEnabled = true
        } else {
            save.alpha = 0.3
            save.isUserInteractionEnabled = false
        }
    }
    
    func errorTextField () {
        let firstNameText = firstNameTextField.text
        let secondNameText = secondNameTextField.text
        if firstNameText == "" || secondNameText == "" {
            let error = UIAlertController(title: "You don't have a first or last name?!", message: "The first or last name field is not filled in.", preferredStyle: .alert)
            error.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(error, animated: true)
        }
    }
}

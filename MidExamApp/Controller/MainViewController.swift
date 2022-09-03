//
//  MainViewController.swift
//  MidExamApp
//
//  Created by WeiFangChou on 2022/8/9.
//

import UIKit

class MainViewController: UIViewController ,UITextFieldDelegate{


    
    
    let urlString = "https://fivem.fangs.dev/quizs.json"
    
    
    var quizs = [Quiz]()

    @IBOutlet weak var enterQuizButton: UIButton!
    @IBOutlet weak var quizPinTextField: UITextField!
    
    var question : [Quiz] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
     
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        quizPinTextField.text?.removeAll()
        fetchData()
    }
    
    func updateUI() {
        fetchData()
        quizPinTextField.delegate = self
        enterQuizButton.setTitle("Enter", for: .normal)
        enterQuizButton.backgroundColor = .darkGray
        enterQuizButton.setTitleColor(.white, for: .selected)
        
        quizPinTextField.keyboardType = .numberPad
        quizPinTextField.becomeFirstResponder()
        
        
    }
    
    
    func fetchData() {
        APICaller().fetchQuizData(urlString: urlString) { result, fetchQuizs in
            self.question.removeAll()
            guard let error = result else {
                return
            }
            if let fetchQuizs = fetchQuizs?.shuffled() {
                for index  in 0..<10 {
                    self.question.append(fetchQuizs[index])
                }
                print(self.question.count)
                
            }
        }
        
    }
    
    @IBAction func enterQuiz(_ sender: UIButton) {
        if let text = quizPinTextField.text, !text.isEmpty {
            if let pinCode = Int(text), pinCode > 0000, pinCode < 10000 {
                if quizs != nil{
                    performSegue(withIdentifier: "showQuiz", sender: sender)
                }else{
                    createAlert(title: "Error", message: "fetch Data Failed", actionTitle: "OK!")
                }
                
            }else{
                createAlert(title: "Error", message: "請輸入Pin", actionTitle: "OK !")
            }
        }
        
    }

    @IBAction func quizPinTextFieldValueChanged(_ sender: UITextField){
        if let text = sender.text {
            
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            if text.count == 4 {
                textField.endEditing(true)
            }else if text.count > 4 {
                textField.text?.removeLast()
                createAlert(title: "Error", message: "PIN 最多4碼", actionTitle: "OK")
            }
        }
    }
    
    func createAlert(title: String, message: String, actionTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? QuizViewController{
            controller.quizs = self.question.shuffled()
        }
    }
}

//
//  ViewController.swift
//  Dojo
//
//  Created by Hızlıgelıyo on 26.12.2021.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var sendNow: UIButton!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextView.delegate = self
        initUI()
    }
    
    func initUI(){
        sendNow.layer.cornerRadius = 8
        sendButton.layer.cornerRadius = 8
        sendNow.backgroundColor = .red
        sendButton.backgroundColor = .green
        sendNow.layer.masksToBounds = true
        sendButton.layer.masksToBounds = true
        emailTextfield.placeholder = "  example@gmail.com"
        emailTextfield.borderStyle = .none
        messageTextView.text = " Message"
        messageTextView.textColor = .lightGray
        sendNow.setTitle("Hemen Yolla", for: .normal)
        sendButton.setTitle("Yolla", for: .normal)
        sendNow.setTitleColor(.white, for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
        bottomLabel.text = "To : \n Message :"
        bottomLabel.textAlignment = .left
        bottomLabel.font = UIFont.systemFont(ofSize: 20)
        
        messageTextView.layer.borderWidth = 1
        messageTextView.layer.borderColor = UIColor.lightGray.cgColor
        messageTextView.layer.cornerRadius = 8
        messageTextView.layer.masksToBounds = true
        
        emailTextfield.layer.borderWidth = 1
        emailTextfield.layer.borderColor = UIColor.lightGray.cgColor
        emailTextfield.layer.cornerRadius = 4
        emailTextfield.layer.masksToBounds = true
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sendMessage(nowOrlater: true)
        case 1:
            sendMessage(nowOrlater: false)
        default:
            displayAlert(message: "Error", title: "Uyarı")
        }
    }
    
    func sendMessage(nowOrlater: Bool ){
        guard let to = emailTextfield.text else { return }
        guard let message = messageTextView.text else { return }
        if message.isEmpty || message == "Message" {
            displayAlert(message: "Enter your message", title: "Uyarı")
            return
        }
        var emails : String = ""
        let emailArray = to.split(separator: ",")
        if !emailArray.isEmpty {
            for index in 0...emailArray.count-1{
                if !String(emailArray[index]).contains("@") {
                    displayAlert(message: "Email adresi hatalı.", title:"Uyarı" )
                    break
                }
                let newEmails = "To :" + String(emailArray[index]) + "\n"
                emails = emails + newEmails
            }
        }
        

        
        let wholeLabel = emails + "Message : " + message
        
        if nowOrlater {
            let messageAttribute = [NSAttributedString.Key.foregroundColor: UIColor.red]
            let wholeMessage = "Message : " + message
            let myAttString = NSAttributedString(string: wholeMessage, attributes: messageAttribute)
            let emails = NSMutableAttributedString(string: emails)
            emails.append(myAttString)
            bottomLabel.attributedText = emails
        }
        else {
            bottomLabel.textColor = .black
            bottomLabel.text = wholeLabel
        }
    }
    
    func displayAlert(message: String,title: String){
 
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
            let okButton = UIAlertAction(title: "Tamam", style: .default) { (UIAlertAction) in
            }
 
            alert.addAction(okButton)

            present(alert, animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if messageTextView.text == " Message" {
            messageTextView.text = ""
            messageTextView.textColor = .black
        }
    }
    

    
    
}



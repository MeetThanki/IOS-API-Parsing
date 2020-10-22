//
//  ViewController.swift
//  JsonParsingOne
//
//  Created by Meet Thanki on 19/10/20.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var edtUsername  : UITextField!
    @IBOutlet weak var edtMobile  : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        edtUsername.text=""
        edtMobile.text=""
        // Do any additional setup after loading the view.
    }

    @IBAction func addPressed(_ sender: Any) {
        callApi()
    }
    func showProgress() {
        let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        Indicator.label.text = "Please Wait"
        Indicator.isUserInteractionEnabled = false
        Indicator.show(animated: true)
    }
    
    func callApi(){
        self.showProgress()
        // prepare parameters
        let parameters = "user_name=\(edtUsername.text!)&user_no=\(edtMobile.text!)"
        
        // 1. create the url
        if let url = URL(string: "https://designtrident.com/Test/add_user.php"){
            
            // 2. create url session
            let session = URLSession(configuration: .default)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            // insert json data to the request
            request.httpBody = parameters.data(using: String.Encoding.utf8)
            
            // 3. give the session task
            let task = session.dataTask(with: request) { (data, response, error) in
                if error != nil{
                    print(error?.localizedDescription as Any)
                    return
                }
                
                if let jsonData = data{
                    let responseJSON = try? JSONSerialization.jsonObject(with: jsonData, options: [])
                    if let responseJSON = responseJSON as? [String:Any] {
                            if responseJSON["status"] as! Bool{
                                DispatchQueue.main.async {
                                    MBProgressHUD.hide(for: self.view, animated: true)
                                    let alert = UIAlertController(title: "Message", message: "User has added Succesful.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                                    self.present(alert, animated: true)
                                    self.viewDidLoad()
                                }
                            }
                            else{
                                DispatchQueue.main.async {
                                    MBProgressHUD.hide(for: self.view, animated: true)
                                    let alert = UIAlertController(title: "Message", message: responseJSON["message"] as? String, preferredStyle: .alert)

                                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                                    self.present(alert, animated: true)
                                }
                            }
                        }
                }
            }
            
            //4. start the task
            task.resume()
        }
    }
}


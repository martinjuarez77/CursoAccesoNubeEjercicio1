//
//  ViewController.swift
//  CursoAccesoNubeEjercicio1
//
//  Created by Martin Juarez on 26/11/16.
//  Copyright © 2016 Martin Juarez Acheritobehere. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var isbn: UILabel!
    
    @IBOutlet weak var seachBox: UITextField!
    
    @IBOutlet weak var isbnResult: UITextView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.seachBox.delegate = self
        self.seachBox.tag = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func textFieldDidEndEditing(textField: UITextField) {
        switch textField.tag {
        case 0:
            recuperaDatosISBN(isbn: textField.text!)
        default: break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let currentTextField = textField
        
        currentTextField.becomeFirstResponder()
        
        recuperaDatosISBN(isbn: textField.text!)
        
        return true
        
    }
    
    func recuperaDatosISBN(isbn : String){
        
        
        var texto : String? = nil
        let urlStr = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbn //978-84-376-0494-7
        let url = NSURL(string: urlStr)
        if (url != nil){
            let datos:NSData? = NSData(contentsOf: url! as URL)
            texto = NSString(data:datos! as Data, encoding:String.Encoding.utf8.rawValue) as? String
            if (texto == nil){
                texto = "No se ha podido establecer conexión con el servidor. Intentelo mas tarde."
            } else if (texto == "{}" || texto == ""){
                texto = "No se han encontrado coincidencias"
            }
        } else {
            texto = "No se ha podido establecer conexión con el servidor. Intentelo mas tarde."
        }
        
        self.isbnResult.text = texto as String!
    
    }
    
    
}


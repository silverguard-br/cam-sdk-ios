//
//  ViewController.swift
//  SilverguardCAM Sample
//
//  Created by Matheus Sanada on 02/07/25.
//

import UIKit
import SilverguardCAM

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var labelE2e: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var fieldAmount: UITextField!
    
    @IBOutlet weak var fieldDestinationBankField: UITextField!
    @IBOutlet weak var fieldDestinationISPB: UITextField!
    @IBOutlet weak var fieldDestinationCompe: UITextField!
    
    @IBOutlet weak var fieldOriginalBankName: UITextField!
    @IBOutlet weak var fieldOriginalBankDocument: UITextField!
    @IBOutlet weak var fieldOriginalBankDocumentType: UITextField!
    
    @IBOutlet weak var fieldDestinationCustomerBankName: UITextField!
    @IBOutlet weak var fieldDestinationCustomerBankDocument: UITextField!
    @IBOutlet weak var fieldDestinationCustomerBankDocumentType: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Silverguard - DICT"
        configureActions()
        configureFields()
        setupDefault()
        SilverguardCAM
            .configure(with: "3|14sa2lC4r0jEKLqUpBWcGowIbkt30ziyNJqWvniQ49b50f69")
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func buttonStart(_ sender: Any) {
        labelE2e.text = UUID().uuidString
        labelDate.text = getDate()
        
        let controller = SilverguardCAM.start(
            with: createModel()
        )
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func createModel() -> DICTModel {
        return DICTModel(
            transaction: DICTTransaction(
                e2e: UUID().uuidString,
                amount: Int(fieldAmount.text ?? "0") ?? 0,
                date: labelDate.text ?? "2025-04-16 11:10:00"
            ),
            destinationBank: DICTBank(
                name: fieldDestinationBankField.text ?? "BCO ITAUBANK S.A.",
                ispb: Int(fieldDestinationISPB.text ?? "") ?? 60394079,
                compe: Int(fieldDestinationCompe.text ?? "") ?? 479
            ),
            originBankCustomer: DICTBankCustomer(
                name: fieldOriginalBankName.text ?? "John Doe",
                document: fieldOriginalBankDocument.text ?? "12345678901",
                documentType: fieldOriginalBankDocumentType.text ?? "cpf"
            ),
            destinationBankCustomer: DICTBankCustomer(
                name: fieldDestinationCustomerBankName.text ?? "Fulano de Tal",
                document: fieldDestinationCustomerBankDocument.text ?? "12345678901234",
                documentType: fieldDestinationCustomerBankDocumentType.text ?? "cnpj"
            )
        )
    }
    
}

extension ViewController {
    private func configureActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        scrollView.keyboardDismissMode = .onDrag
    }

    private func setupDefault() {
        labelE2e.text = UUID().uuidString
        labelDate.text = getDate()
        fieldAmount.text = "100"
        
        fieldDestinationBankField.text = "BCO ITAUBANK S.A."
        fieldDestinationISPB.text = "60394079"
        fieldDestinationCompe.text = "479"
        
        fieldOriginalBankName.text = "John Doe"
        fieldOriginalBankDocument.text = "12345678901"
        fieldOriginalBankDocumentType.text = "cpf"
        
        fieldDestinationCustomerBankName.text = "Fulano de Tal"
        fieldDestinationCustomerBankDocument.text = "12345678901234"
        fieldDestinationCustomerBankDocumentType.text = "cnpj"
    }

    private func configureFields() {
        fieldAmount.keyboardType = .decimalPad
        fieldDestinationISPB.keyboardType = .numberPad
        fieldDestinationCompe.keyboardType = .numberPad
    }
    
    private func getDate() -> String? {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.timeZone = TimeZone(identifier: "America/Sao_Paulo")
        let formattedString = formatter.string(from: date)
        return formattedString
    }

}

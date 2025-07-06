import Foundation

public struct DICTModel: BodyEncodable {
    let transaction: DICTTransaction
    let destinationBank: DICTBank
    let originBankCustomer: DICTBankCustomer
    let destinationBankCustomer: DICTBankCustomer
    
    public init(
        transaction: DICTTransaction,
        destinationBank: DICTBank,
        originBankCustomer: DICTBankCustomer,
        destinationBankCustomer: DICTBankCustomer
    ) {
        self.transaction = transaction
        self.destinationBank = destinationBank
        self.originBankCustomer = originBankCustomer
        self.destinationBankCustomer = destinationBankCustomer
    }
}

public struct DICTTransaction: BodyEncodable {
    let e2e: String
    let amount: Int
    let date: String
    
    public init(e2e: String, amount: Int, date: String) {
        self.e2e = e2e
        self.amount = amount
        self.date = date
    }
}

public struct DICTBank: BodyEncodable {
    let name: String
    let ispb: Int
    let compe: Int
    
    public init(name: String, ispb: Int, compe: Int) {
        self.name = name
        self.ispb = ispb
        self.compe = compe
    }
}

public struct DICTBankCustomer: BodyEncodable {
    let name: String
    let document: String
    let documentType: String
    
    public init(name: String, document: String, documentType: String) {
        self.name = name
        self.document = document
        self.documentType = documentType
    }
}

//
//  Economat.swift
//  GestionEtablissementScolaire
//
//  Created by Djedly-Fitz GEROME on 09/10/25.
//

import Foundation

class Transaction {
    let id: UUID
    let type: String
    let montant: Double
    let description: String
    let date: Date
    
    init(type: String, montant: Double, description: String) {
        self.id = UUID()
        self.type = type
        self.montant = montant
        self.description = description
        self.date = Date()
    }
    
    func afficher() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        print("\(type.uppercased()) - \(montant) HTG - \(description) - \(formatter.string(from: date))")
    }
}


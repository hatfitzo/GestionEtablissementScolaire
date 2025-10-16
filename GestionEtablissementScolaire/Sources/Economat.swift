//
//  Economat.swift
//  GestionEtablissementScolaire
//
//  Created by Roulopheny AUGUSTAVE on 10/11/25.
//

import Foundation

class Economat {
    private var transactions: [Transaction]
    
    init() {
        self.transactions = []
    }
    
    func ajouterTransaction(type: String, montant: Double, description: String) {
        let transaction = Transaction(type: type, montant: montant, description: description)
        transactions.append(transaction)
        print(" Transaction ajoutée avec succès!")
    }
    
    func listerTransactions() {
        if transactions.isEmpty {
            print(" Aucune transaction enregistrée.")
            return
        }
        
        print("\n LISTE DES TRANSACTIONS:")
        print("=" * 50)
        for (index, transaction) in transactions.enumerated() {
            print("\(index + 1). ", terminator: "")
            transaction.afficher()
        }
        print("=" * 50)
    }
    
    func calculerSolde() -> Double {
        var solde: Double = 0
        for transaction in transactions {
            if transaction.type.lowercased() == "Depot" {
                solde += transaction.montant
            } else if transaction.type.lowercased() == "Retrait" {
                solde -= transaction.montant
            }
        }
        return solde
    }
    
    func afficherSolde() {
        let solde = calculerSolde()
        print("\n SOLDE ACTUEL: \(String(format: "%.2f", solde)) HTG")
        if solde > 0 {
            print(" Situation financière: Positive")
        } else if solde < 0 {
            print("Situation financière: Négative")
        } else {
            print(" Situation financière: Équilibrée")
        }
    }
}

extension String {
    static func * (left: String, right: Int) -> String {
        return String(repeating: left, count: right)
    }
}

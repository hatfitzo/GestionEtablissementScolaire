//
//  Economat.swift
//  GestionEtablissementScolaire
//
//  Created by Djedly-Fitz GEROME on 10/13/25.
//

import Foundation

class GestionEtablissement {
    private var etudiants: [Etudiant]
    private var economat: Economat
    
    init() {
        self.etudiants = []
        self.economat = Economat()
    }
    
    func afficherMenuPrincipal() {
        print("\n" + "=" * 60)
        print("UNIVERSITÉ D'ÉTAT D'HÄTTI")
        print("   Campus Henry Christophe de Limonade")
        print("   Faculté des Sciences et de Génie (FSG)")
        print("=" * 60)
        print("1.  Gestion des Étudiants")
        print("2.  Gestion de l'Économat")
        print("3. Quitter")
        print("=" * 60)
        print("Votre choix (1-3): ", terminator: "")
    }
    
    func afficherMenuEtudiants() {
        print("\n" + "=" * 40)
        print(" GESTION DES ÉTUDIANTS")
        print("=" * 40)
        print("1. Ajouter un étudiant")
        print("2. Lister tous les étudiants")
        print("3. Ajouter des notes")
        print("4. Calculer les moyennes")
        print("5. Retour au menu principal")
        print("=" * 40)
        print("Votre choix (1-5): ", terminator: "")
    }
    
    func afficherMenuEconomat() {
        print("\n" + "=" * 40)
        print(" GESTION DE L'ÉCONOMAT")
        print("=" * 40)
        print("1.  Ajouter une transaction")
        print("2. Lister toutes les transactions")
        print("3. Calculer le solde actuel")
        print("4. Retour au menu principal")
        print("=" * 40)
        print("Votre choix (1-4): ", terminator: "")
    }

    func gererEtudiants() {
        while true {
            afficherMenuEtudiants()
            
            if let choix = readLine(), let option = Int(choix) {
                switch option {
                case 1:
                    ajouterEtudiant()
                case 2:
                    listerEtudiants()
                case 3:
                    ajouterNotes()
                case 4:
                    calculerMoyennes()
                case 5:
                    return
                default:
                    print("Option invalide! Veuillez choisir entre 1 et 5.")
                }
            } else {
                print(" Veuillez entrer un nombre valide.")
            }
        }
    }
    
    func gererEconomat() {
        while true {
            afficherMenuEconomat()
            
            if let choix = readLine(), let option = Int(choix) {
                switch option {
                case 1:
                    ajouterTransaction()
                case 2:
                    economat.listerTransactions()
                case 3:
                    economat.afficherSolde()
                case 4:
                    return
                default:
                    print("Option invalide! Veuillez choisir entre 1 et 4.")
                }
            } else {
                print(" Veuillez entrer un nombre valide.")
            }
        }
    }
    
    func ajouterEtudiant() {
        print("\nAJOUT D'UN NOUVEL ÉTUDIANT")
        
        print("Nom: ", terminator: "")
        guard let nom = readLine(), !nom.isEmpty else {
            print("Le nom ne peut pas être vide.")
            return
        }
        
        print("Prénom: ", terminator: "")
        guard let prenom = readLine(), !prenom.isEmpty else {
            print("Le prénom ne peut pas être vide.")
            return
        }
        
        print("Matricule: ", terminator: "")
        guard let matricule = readLine(), !matricule.isEmpty else {
            print("Le matricule ne peut pas être vide.")
            return
        }
        
        if etudiants.contains(where: { $0.matricule == matricule }) {
            print("Un étudiant avec ce matricule existe déjà.")
            return
        }
        
        print("Niveau (ex: CPI-1, CPI-2, Licence 3, Licence 4): ", terminator: "")
        guard let niveau = readLine(), !niveau.isEmpty else {
            print("Le niveau ne peut pas être vide.")
            return
        }
        
        let etudiant = Etudiant(nom: nom, prenom: prenom, matricule: matricule, niveau: niveau)
        etudiants.append(etudiant)
        print("Étudiant ajouté avec succès !")
    }
    
    func listerEtudiants() {
        if etudiants.isEmpty {
            print("\nAucun étudiant enregistré.")
            return
        }
        
        print("\nLISTE DES ÉTUDIANTS:")
        print(String(repeating: "=", count: 50))
        for (index, etudiant) in etudiants.enumerated() {
            print("\(index + 1). \(etudiant.matricule) - \(etudiant.nom) \(etudiant.prenom) | Niveau: \(etudiant.niveau)")
        }
        print(String(repeating: "=", count: 50))
        print("Total: \(etudiants.count) étudiant(s)")
    }

    func ajouterNotes() {
        if etudiants.isEmpty {
            print("Aucun étudiant enregistré. Veuillez d'abord ajouter un étudiant.")
            return
        }
        
        print("\nAJOUT DE NOTES")
        listerEtudiants()
        print("\nNuméro de l'étudiant: ", terminator: "")
        
        guard let input = readLine(),
              let index = Int(input),
              index > 0, index <= etudiants.count else {
            print("Numéro d'étudiant invalide.")
            return
        }
        
        let etudiant = etudiants[index - 1]
        
        print("Matière: ", terminator: "")
        guard let matiere = readLine(), !matiere.isEmpty else {
            print("La matière ne peut pas être vide.")
            return
        }
        
        func lireNote(_ type: String) -> Double? {
            print("Note \(type) (0 à 100): ", terminator: "")
            guard let input = readLine(),
                  let note = Double(input),
                  note >= 0, note <= 100 else {
                print("Note \(type) invalide. Doit être entre 0 et 100.")
                return nil
            }
            return note
        }
        
        guard let noteIntra = lireNote("Intra"),
              let noteDevoir = lireNote("Devoir"),
              let noteFinal = lireNote("Final") else {
            return
        }
        
        etudiant.ajouterNote(matiere: matiere, note: noteIntra)
        etudiant.ajouterNote(matiere: matiere, note: noteDevoir)
        etudiant.ajouterNote(matiere: matiere, note: noteFinal)
        
        if let moyenne = etudiant.calculerMoyenneMatiere(matiere: matiere) {
            print(" Notes ajoutées avec succès!")
            print("Moyenne en \(matiere): \(String(format: "%.2f", moyenne))/100")
        }
    }
   
    func calculerMoyennes() {
        if etudiants.isEmpty {
            print("Aucun étudiant enregistré.")
            return
        }
        
        print("\nMOYENNES DES ÉTUDIANTS")
        print(String(repeating: "=", count: 60))
        
        for etudiant in etudiants {
            print("\n\(etudiant.matricule) - \(etudiant.nom) \(etudiant.prenom)")
            
            if etudiant.notes.isEmpty {
                print("  Aucune note enregistrée.")
            } else {
                var somme = 0.0
                var compteur = 0
                
                for (matiere, _) in etudiant.notes {
                    if let moyenne = etudiant.calculerMoyenneMatiere(matiere: matiere) {
                        let mention = getMention(moyenne: moyenne)
                        print("  \(matiere): \(String(format: "%.2f", moyenne))/100 - \(mention)")
                        somme += moyenne
                        compteur += 1
                    }
                }
                
                if compteur > 0 {
                    let moyenneGenerale = somme / Double(compteur)
                    let mentionGenerale = getMention(moyenne: moyenneGenerale)
                    print("  Moyenne générale: \(String(format: "%.2f", moyenneGenerale))/100 - \(mentionGenerale)")
                }
            }
        }
        
        print(String(repeating: "=", count: 60))
    }

    func ajouterTransaction() {
        
        print("\nAJOUT D'UNE TRANSACTION")
        
        var type: String
        while true {
            print("Type de transaction:")
            print("1. Depot(paiement scolaire, partenariat...)")
            print("2. Retrait(Payroll, remboursement de prêt...)")
            print("3. Retour au menu principal")
            print("Choisissez (1, 2 ou 3): ", terminator: "")
            
            guard let choix = readLine(), !choix.isEmpty else {
                print("Le choix ne peut pas etre vide.")
                continue
            }
            
            switch choix {
            case "1":
                type = "depot"
                break
            case "2":
                type = "retrait"
                break
            case "3":
                print("Retour au menu principal...")
                return
            default:
                print("Choix invalide. Veuillez choisir 1, 2 ou 3.")
                continue
            }
            break
        }

                var montant: Double = 0
        while montant <= 0 {
            print("Montant (HTG) ou 'annuler' pour retourner: ", terminator: "")
            guard let input = readLine(), !input.isEmpty else {
                print("Le montant ne peut pas etre vide.")
                continue
            }
            
            if input.lowercased() == "annuler" {
                print("Operation annulee. Retour au menu principal...")
                return
            }
            
            let inputNettoye = input.replacingOccurrences(of: ",", with: ".")
            guard let valeur = Double(inputNettoye), valeur > 0 else {
                print("Montant invalide. Entrez un nombre positif.")
                continue
            }
            montant = valeur
        }
        
        var description = ""
        while description.isEmpty {
            print("Description ou 'annuler' pour retourner: ", terminator: "")
            guard let desc = readLine(), !desc.isEmpty else {
                print("La description ne peut pas etre vide.")
                continue
            }
            
            if desc.lowercased() == "annuler" {
                print("Operation annulee. Retour au menu principal...")
                return
            }
            
            description = desc
        }
        
        economat.ajouterTransaction(type: type, montant: montant, description: description)
        print("Transaction ajoutee avec succes!")
    }
    private func getMention(moyenne: Double) -> String {
        switch moyenne {
        case 65...100: return "Admis(e)"
        case 50..<65: return "Reprise"
        case 21..<50: return "Vous avez a reprendre le cours"
        default: return "Cas grave,Cas Special"
        }
    }
    
    func demarrer() {
        print(" Démarrage du système de gestion scolaire...")
        
        while true {
            afficherMenuPrincipal()
            
            if let choix = readLine(), let option = Int(choix) {
                switch option {
                case 1:
                    gererEtudiants()
                case 2:
                    gererEconomat()
                case 3:
                    print("\n Merci d'avoir utilisé notre système!")
                    print("À bientôt! ")
                    return
                default:
                    print(" Option invalide! Veuillez choisir entre 1 et 3.")
                }
            } else {
                print(" Veuillez entrer un nombre valide.")
            }
        }
    }
}

// Point d'entrée du programme
let gestionEtablissement = GestionEtablissement()
gestionEtablissement.demarrer()

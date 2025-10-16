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
    

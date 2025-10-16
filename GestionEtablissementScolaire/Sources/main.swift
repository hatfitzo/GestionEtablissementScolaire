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

//
//  Etudiant.swift
//  GestionEtablissementScolaire
//
//  Created by Roulopheny AUGUSTAVE on 10/11/25.
//
import Foundation

class Etudiant {
    let id: UUID
    var nom: String
    var prenom: String
    var matricule: String
    var niveau: String
    var notes: [String: [Double]]
    
    init(nom: String, prenom: String, matricule: String, niveau: String) {
        self.id = UUID()
        self.nom = nom
        self.prenom = prenom
        self.matricule = matricule
        self.niveau = niveau
        self.notes = [:]
    }
    
    func ajouterNote(matiere: String, note: Double) {
        if notes[matiere] == nil {
            notes[matiere] = []
        }
        notes[matiere]?.append(note)
    }
    
    func calculerMoyenneMatiere(matiere: String) -> Double? {
        guard let notesMatiere = notes[matiere], !notesMatiere.isEmpty else {
            return nil
        }
        return notesMatiere.reduce(0, +) / Double(notesMatiere.count)
    }
    
    func afficher() {
        print("\(matricule) - \(nom) \(prenom)")
        for (matiere, notesMatiere) in notes {
            if let moyenne = calculerMoyenneMatiere(matiere: matiere) {
                print("  \(matiere): \(notesMatiere) → Moyenne: \(String(format: "%.2f", moyenne))")
            }
        }
    }
}

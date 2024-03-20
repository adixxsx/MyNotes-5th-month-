//
//  NoteModel.swift
//  MyNotes(5th-month)
//
//  Created by user on 19/3/24.
//

import Foundation

protocol NoteModelProtocol {
    func AddNote(note: Note?, title: String, description: String)
    
    func deleteNote(id: String)
}

class NoteModel: NoteModelProtocol {
   
    private let coreDataService = CoreDataService.shared
    
    var controller: NoteControllerProtocol?
    
    init(controller: NoteControllerProtocol) {
        self.controller = controller
    }
    
    func AddNote(note: Note?, title: String, description: String) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: currentDate)
        
        if let note = note {
            coreDataService.updateNote(id: note.id ?? "", title: title, description: description, date: dateString)
        } else {
            let id = UUID().uuidString

            coreDataService.addNote(id: id, title: title, description: description, date: dateString) { response in
                if response == .success {
                    self.controller?.onSuccesAddNote()
                } else {
                    self.controller?.onFailureAddNote()
                }
            }
        }
        
    }
    
    func deleteNote(id: String) {
        coreDataService.delete(id: id) { response in
            if response == .success {
                self.controller?.onSuccesDelete()
            } else {
                self.controller?.onFailureDelete()
            }
        }
        
    }
    
}

//
//  NoteController.swift
//  MyNotes(5th-month)
//
//  Created by user on 19/3/24.
//

import Foundation

protocol NoteControllerProtocol {
    
    func onAddNote(note: Note?, title: String, description: String)
    
    func onSuccesAddNote()
    
    func onFailureAddNote()
    
    func onDeleteNote(id: String)
    
    func onSuccesDelete()
    
    func onFailureDelete()
    
}

class NoteController: NoteControllerProtocol {
 
    var view: NoteViewProtocol?
    var model: NoteModelProtocol?
    
    init(view: NoteViewProtocol) {
        self.view = view
        self.model = NoteModel(controller: self)
    }
   
    func onAddNote(note: Note?, title: String, description: String) {
        model?.AddNote(note: note, title: title, description: description)
    }
    
    func onSuccesAddNote() {
        view?.successAddNote()
    }
    
    func onFailureAddNote() {
        view?.failureAddNote()
    }

    func onDeleteNote(id: String) {
        model?.deleteNote(id: id)
    }
    
    func onSuccesDelete() {
        view?.succesDelete()
    }
    
    func onFailureDelete() {
        view?.failureDelete()
    }
    
}

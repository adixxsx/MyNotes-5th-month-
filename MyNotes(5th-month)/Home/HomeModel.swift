//
//  HomeModel.swift
//  MyNotes(5th-month)
//
//  Created by user on 21/2/24.
//

protocol HomeModelProtocol {
    func getNotes()
}

class HomeModel: HomeModelProtocol {
   
    private let controller: HomeControllerProtocol?
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    private var notes: [String] = ["Do homework", "Buy gigabyte", "Meet friends", "Go to the gym!"]
    
    func getNotes() {
        controller?.onSuccessNotes(notes: notes)
    }
}

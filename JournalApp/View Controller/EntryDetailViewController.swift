//
//  EntryDetailViewController.swift
//  JournalApp
//
//  Created by Jonathan Llewellyn on 11/8/21.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var entryDetailTextView: UITextView!
    
    // MARK: - Properties
    // Our landing pad
    var entry: Entry?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up our delegates
        titleTextField.delegate = self
        entryDetailTextView.delegate = self
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func savedButtonTapped(_ sender: Any) {
        // Making sure that we have text:
        guard let title = titleTextField.text, !title.isEmpty, let body = entryDetailTextView.text else {return}
        // If we have an entry, we will update it
        if let entry = entry {
            EntryController.shared.updateEntry(entry: entry, title: title, body: body)
            // If we don't have an entry, we are going to create one
        } else {
            EntryController.shared.createEntryWith(title: title, body: body)
        }
        //Removes the top view off of our Navigation Stack
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        //Clears out all text
        titleTextField.text = ""
        entryDetailTextView.text = ""
    }
    
    //MARK: Helper
    /**
     - Description: If we have an Entry then the user wants to update or view that Entry. In order to allow them to do that we are going to display the data from our passed entry. If we don't have an entry then the user is creating a new entry so we have no need to load any data
     */
    func updateViews() {
        guard let entry = entry else {return}
        titleTextField.text = entry.title
        entryDetailTextView.text = entry.body
    }
    
    // MARK: - Delegate Functions
    ///Going to get called when we press return while typing in a textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    ///Going to get called when we press return while typing in a textView
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //check to see if the character is a new line, or a return. If it is, then we resign first responder
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

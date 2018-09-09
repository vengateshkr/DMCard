//
//  ViewController.swift
//  DMCard
//
//  Created by Venkatesh on 08/09/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var mobileTxtFld: UITextField!
    @IBOutlet weak var addressTxtFld: UITextField!
    @IBOutlet weak var searchTblView: UITableView!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var containerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var manualEntryBtn: UIButton!
    
    @IBOutlet weak var manualEntryContainerStackView: UIStackView!
    @IBOutlet weak var manualEntryMobileTxtFld: UITextField!
    @IBOutlet weak var manualEntryaddressLine1TxtFld: UITextField!
    @IBOutlet weak var manualEntryaddressLine2TxtFld: UITextField!
    @IBOutlet weak var manualPostCodeTxtFld: UITextField!
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileTxtFld.layer.borderColor = UIColor.lightGray.cgColor
        mobileTxtFld.layer.borderWidth = 0.5
        addressTxtFld.layer.borderColor = UIColor.lightGray.cgColor
        addressTxtFld.layer.borderWidth = 0.5
        manualEntryaddressLine1TxtFld.layer.borderColor = UIColor.lightGray.cgColor
        manualEntryaddressLine1TxtFld.layer.borderWidth = 0.5
        manualEntryaddressLine2TxtFld.layer.borderColor = UIColor.lightGray.cgColor
        manualEntryaddressLine2TxtFld.layer.borderWidth = 0.5
        manualEntryMobileTxtFld.layer.borderColor = UIColor.lightGray.cgColor
        manualEntryMobileTxtFld.layer.borderWidth = 0.5
        manualPostCodeTxtFld.layer.borderColor = UIColor.lightGray.cgColor
        manualPostCodeTxtFld.layer.borderWidth = 0.5
        
        self.searchTblView.isHidden = true
        self.manualEntryBtn.isHidden = true
        manualEntryContainerStackView.isHidden = true
        
        //Add done button to numeric pad keyboard
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done,
                                              target: self, action: #selector(doneButton_Clicked))
        
        toolbarDone.items = [barBtnDone] // You can even add cancel button too
        mobileTxtFld.inputAccessoryView = toolbarDone
        addressTxtFld.inputAccessoryView = toolbarDone
        manualEntryMobileTxtFld.inputAccessoryView = toolbarDone
        manualPostCodeTxtFld.inputAccessoryView = toolbarDone
        manualEntryaddressLine1TxtFld.inputAccessoryView = toolbarDone
        manualEntryaddressLine2TxtFld.inputAccessoryView = toolbarDone

    }
    
    @objc func doneButton_Clicked(){
        mobileTxtFld.resignFirstResponder()
        addressTxtFld.resignFirstResponder()
        manualEntryMobileTxtFld.resignFirstResponder()
        manualEntryaddressLine1TxtFld.resignFirstResponder()
        manualEntryaddressLine2TxtFld.resignFirstResponder()
        manualPostCodeTxtFld.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UITableView delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SearchResultsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchResultsTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: SearchResultsTableViewCell =  tableView.cellForRow(at: indexPath) as! SearchResultsTableViewCell
        
        UIView.animate(withDuration: 0.2) {
            self.searchTblView.isHidden = true
            self.manualEntryBtn.isHidden = true
        }
        self.addressTxtFld.text = cell.searchResultLabel.text ?? ""
        self.addressTxtFld.endEditing(true)
    }
    
    //MARK:- UIButton action methods
    @IBAction func manualEntryBtnClicked(_ sender: Any) {
        self.addressTxtFld.resignFirstResponder()
        self.mobileTxtFld.resignFirstResponder()
        UIView.animate(withDuration: 0.2) {
            self.searchTblView.isHidden = true
            self.manualEntryBtn.isHidden = true
        }
        containerStackView.isHidden = true
        manualEntryContainerStackView.isHidden = false
    }
    
    //MARK:- UITextField delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4) {
            self.containerTopConstraint.constant = -180
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4) {
            self.containerTopConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == self.addressTxtFld else { return true }
        let length = (textField.text?.count)! - range.length + string.count
        if length > 2 {
            UIView.animate(withDuration: 0.2) {
                self.searchTblView.isHidden = false
                self.manualEntryBtn.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.searchTblView.isHidden = true
                self.manualEntryBtn.isHidden = true
            }
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        UIView.animate(withDuration: 0.2) {
            self.searchTblView.isHidden = true
            self.manualEntryBtn.isHidden = true
        }
        return true
    }
}

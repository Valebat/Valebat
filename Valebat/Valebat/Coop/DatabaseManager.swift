//
//  DatabaseManager.swift
//  Valebat
//
//  Created by Sreyans Sipani on 28/4/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseDatabase

class DatabaseManager {
    private var ref: DatabaseReference = Database.database().reference()
    private var fdb = Firestore.firestore()

    func fetchDocuments(from collectionName: String) -> [QueryDocumentSnapshot] {
        var result = [QueryDocumentSnapshot]()
        fdb.collection(collectionName).getDocuments { (querySnapshot, error) in
            if let err = error {
                print("[Fetch \(collectionName)] Database error: \(err).")
                result = []
            } else {
                result = querySnapshot?.documents ?? []
            }
        }
        return result
    }

    func add<T: Encodable>(document: T, to collectionName: String) throws {
        try fdb.collection(collectionName).addDocument(from: document)
    }
    
    func fetchDocument(from collectionName: String, where field: String, equals value: String) -> QueryDocumentSnapshot? {
        var result: QueryDocumentSnapshot?
        fdb.collection(collectionName).whereField(field, isEqualTo: value)
            .getDocuments { (querySnapshot, error) in
                if let err = error {
                    print("[Fetch Room] Database error: \(err)")
                    result = nil
                } else {
                    result = querySnapshot?.documents.first
                }
            }
        return result
    }
    
    func set<T: Encodable>(data: [String: T], in collectionName: String, for docNumber: String,
                           merge: Bool = true) {
        fdb.collection(collectionName).document(docNumber).setData(data, merge: true)
    }
    
    func removeValue(from childPath: String) {
        self.ref.child(childPath).removeValue()
    }
    
    func updateValues(with updates: [String: Any]) {
        self.ref.updateChildValues(updates)
    }
    
    func getValue(from childPath: String) -> [String: Any] {
        var result = [String: Any]()
        self.ref.child(childPath).getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            } else if snapshot.exists() {
                result = snapshot.value as? [String: Any] ?? [:]
            }
        }
        return result
    }
}

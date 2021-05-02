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

    func fetchDocuments(from collectionName: String, completed: @escaping ([QueryDocumentSnapshot]) -> Void) {
        fdb.collection(collectionName).getDocuments { (querySnapshot, error) in
            var result = [QueryDocumentSnapshot]()
            if let err = error {
                print("[Fetch \(collectionName)] Database error: \(err).")
            } else {
                result = querySnapshot?.documents ?? []
            }
            completed(result)
        }
    }

    func add<T: Encodable>(document: T, to collectionName: String) throws {
        try fdb.collection(collectionName).addDocument(from: document)
    }

    func add<T: Encodable>(document: T, to collectionName: String, completed: @escaping () -> Void) throws {
        try fdb.collection(collectionName).addDocument(from: document, completion: { (err) in
            if let error = err {
                print(error)
            } else {
                completed()
            }
        })
    }

    func fetchDocument(from collectionName: String, where field: String, equals value: String,
                       completed: @escaping (QueryDocumentSnapshot?) -> Void) {
        self.fdb.collection(collectionName).whereField(field, isEqualTo: value)
            .getDocuments { (querySnapshot, error) in
                var result: QueryDocumentSnapshot?
                if let err = error {
                    print("[Fetch Room] Database error: \(err)")
                    result = nil
                } else {
                    result = querySnapshot?.documents.first
                }
                completed(result)
            }
    }

    func set<T: Encodable>(data: [String: T], in collectionName: String, for docNumber: String,
                           merge: Bool = true) {
        fdb.collection(collectionName).document(docNumber).setData(data, merge: true)
    }

    func removeValue(from childPath: String) {
        self.ref.child(childPath).removeValue()
    }

    func removeValue(from childPath: String, completed: @escaping () -> Void) {
        self.ref.child(childPath).removeValue(completionBlock: { (err, _) in
            if let error = err {
                print(error)
            }
            completed()
        })
    }

    func updateValues(with updates: [String: Any]) {
        self.ref.updateChildValues(updates)
    }

    func getValue(from childPath: String, completed: @escaping ([String: Any]) -> Void) {
        self.ref.child(childPath).getData { (error, snapshot) in
            var result: [String: Any] = [:]
            if let error = error {
                print("Error getting data \(error)")
            } else if snapshot.exists() {
                result = snapshot.value as? [String: Any] ?? [:]
            }
            completed(result)
        }
    }
}

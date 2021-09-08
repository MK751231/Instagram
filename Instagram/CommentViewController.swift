//
//  CommentViewController.swift
//  Instagram
//
//  Created by 越川将人 on 2021/09/03.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    // 投稿データを格納する配列
    var postArray: [PostData] = []
    var documentID: String = ""
    
    // Firestoreのリスナー
    var listener: ListenerRegistration?

    @IBAction func handleCommentButton(_ sender: Any) {
        
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        
        // FireStoreに投稿データを保存する
        let name = Auth.auth().currentUser?.displayName
        
        let comments = name! + ": " + self.textField.text!
        // コメントデータを作成する
        var commentValue: FieldValue
        commentValue = FieldValue.arrayUnion([comments])

        let postRef = Firestore.firestore().collection(Const.PostPath).document(documentID)
        postRef.updateData(["comments": commentValue])
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "コメントしました")
        // コメント投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func hundleCancelButton(_ sender: Any) {
        // 画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser?.displayName
        commentLabel.text = "\(user!)のコメント書き込み"

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ContentView.swift
//  TextfieldApp
//
//  Created by emi oiso on 2023/10/10.
//

import SwiftUI

struct ContentView: View {
    //キーボード等の外部入力から値の初期値
    @State var inputText = ""
    //遷移画面に遷移するタイミングの初期値
    @State var helloUserView = false
    // エラーメッセージの状態
    @State var errorMessage = ""
    
    var body: some View {
        //出力したい文字列や、TextFieldの枠、Buttonの位置を縦並びにする。
        VStack {
            Text("ユーザー名を記入してください。")
            //TextFieldの枠内に表示させたい文字を枠内に記述させる。
            TextField(
                "ユーザー名を記入",
                //キーボード等の外部入力から値を受け取り、TextFieldの枠内に表示させる。
                text:$inputText
            )
                //キーボード等の外部入力から英字を入力する際、小文字で入力できるようにしている。
                .autocapitalization(.none)
                //TextFieldの枠のコーナーを丸くなるようにしている。
                .textFieldStyle(.roundedBorder)
                //Text()、TextField()、Button()の間隔をいい感じに調節してくれる。
                .padding()
            // エラーメッセージを表示
            Text(errorMessage)
            //エラーメッセージの色を赤に設定
                .foregroundColor(.red)
            //決定ボタンの動作や設定を決める。
            Button(action: {
                //決定ボタンが機能しているか確認したいからユーザー画面には出力されないが、
                //コンソールで確認ができるようにデバックしている。
                print("button pressed")
                //決定ボタンがクリックされたら、遷移画面が遷移しても良いという印をつけてる。
                helloUserView = true
                //でもユーザー名が未記入の場合、エラーメッセージを出力するよという処理。
                if inputText.isEmpty {
                    //ユーザー名が空の場合、エラーメッセージを設定
                    errorMessage = "※ユーザー名が未記入です。"
                    //ユーザー名が空の場合、遷移画面に遷移はさせないという印をつける。
                    helloUserView = false
                }
            },label:  {
                //ボタンの名前を決めてる。
                Text("決定")
                    .frame(width: 100,height: 50)
                    //決定の文字の色は白にしたよ。
                    .foregroundColor(Color.white)
                    //ボタンの色はオレンジにしたよ。
                    .background(Color.orange)
                    //ボタンの角の丸の半径を10に設定したよ。
                    .cornerRadius(10)
            })
            .sheet(isPresented: $helloUserView) {
                //遷移先のページにキーボード等の外部入力から受け取った値を渡すよ。
                TextfieldApp.helloUserView(username: inputText)
            }
        }
        .padding()
    }
}
//遷移先のシートの設定だよ
struct helloUserView: View {
    //ユーザー名は文字型で入力されるよ、だから文字型で準備していてね。
    var username: String
    var body:some View {
        //入力された文字 + さん、こんにちは。で出力するよ。
        Text("\(username)さん、こんにちは。")
    }
}
#Preview {
    ContentView()
}



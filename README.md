■**サービス概要**

ホラー映画を見るだけでダイエットができるアプリです。
目標体重と期間からユーザーにホラー映画視聴本数を提案します。
楽しみながらカロリーを消費し、健康的な生活習慣を促進します。

■ **このサービスへの思い・作りたい理由**

2012年のウエストミンスター大学の研究では、体重50㎏の女性が90分のホラー映画を観ると、30分間ほどウォーキングをしたのと同じ約113カロリーを消費することが明らかになっています。
恐い映像やホラー映画の視聴後に感じる疲労感は、恐怖や緊張によって引き起こされる心拍数の上昇や基礎代謝の増加により、カロリーが消費されると考えられます。さらに、「悲しみ」「怒り」の感情体験は食欲の低下を引き起こすことがわかっています。
ホラー映画が好きな人にとっては、映画を見ながらダイエットができるサービスになり、ダイエット中の人は、ダイエットのしんどい時間がホラー映画を鑑賞することで楽しく続けられると思いました。

■ **ユーザー層について**

ホラー映画を鑑賞する人に、ダイエットというさらなる付加価値を見出すことができます。
またダイエットしている人は、このサービスを利用することで楽しみながらダイエットを行うことができます。
楽しさと効果を両立させ、モチベーションを高めながらダイエットの成功に導きます。
忙しい現代社会において、映画鑑賞が時間の価値を見出さない人々にも、ダイエットも兼ねていると思えば罪悪感なくホラー映画を鑑賞できるのではないか、ホラー映画鑑賞を始めるきっかけになるのではないかと考えます。

■**サービスの利用イメージ**

- アプリに目標体重と目標期間を設定します。
- アプリは目標に達するために必要なホラー映画の視聴本数を提案します。
-  視聴した映画や消費カロリーはアプリに記録され、進捗が追跡されます。

■ **ユーザーの獲得について**

X（Twitter）

■ **サービスの差別化ポイント・推しポイント**

差別化ポイントは、ホラー映画を視聴することでカロリーを消費するというアプローチができることです。従来のダイエットアプリとは異なり、ユーザーは楽しみながらダイエットを行うことができます。

■ **機能候補**

**MVPリリース時に作っていたいもの**
- 会員登録
- ユーザー編集機能
- ログイン（登録後自動ログイン）/ログアウト機能
- ユーザーのプロフィール編集
- 目標体重（性別、身長、体重、目標体重、目標期間）
- プロフィール編集画面より体重を編集し、推移をグラフで表示
- カロリー消費の推定機能
- 映画検索機能
- 映画視聴履歴
- ゲストログイン機能
- 利用規約、プライバシーポリシー
- 退会
- パスワードリセット機能
- 管理者機能

**本リリースまでに作っていたいもの**
- ホラー映画の推薦機能
- 映画レビュー機能
  
■ **機能の実装方針予定**

- The Movie Database (TMDb) API
  映画検索機能：ユーザーがホラー映画を検索し、タイトル等の詳細情報を取得できるようにします。
  
- Open AI API(GPT-4)
　ホラー映画の推薦機能：ユーザーの好みに基づいて最適なホラー映画を推薦する際に使用します。

- Goolge API
  Google Sign-Inを使用してユーザーにログインさせる場合に使用します。

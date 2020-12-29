# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
####### source

Source.create(name: "Dcard")
####### board

Board.create(name: "感情", source_id: "1")

#########################post
Post.create(content: "跟自己心動對象前陣子有在聊天 雖然我們的話題都能慢慢接下去 他不會句點我 但是他真的都過兩三個小時才會回 也都不會主動 我明白他沒有喜歡我 身邊的朋友也都勸我放棄 但放棄了一個月之後 我發現跟他聊天的時候真的很開心 在這個月也遇見了很喜歡我的人 但就算對我再好 我也覺得我跟他相處的開心值比不上我喜歡的人 所以覺得還沒辦法去接受 
  
  目前調整了自己的得失心 保持著反正就當跟朋友聊天 我覺得開心就好 就繼續找喜歡的人聊天了 也跟他說了如果覺得煩可以說 不知道自己做得對不對...", title: "愛人與被愛", created_at: "2020-12-28T05:51:19", updated_at: "2020-12-28T05:51:19", comment_count: "0", like_count: "0", post_number: "235065690", board_id: "1", board_number: "229")

Post.create(content: "我跟我男朋友都在同一個縣市讀書
    騎車到對方學校大概10分鐘
    但因為他比較忙、課業壓力大
    所以我們通常都是兩週見一次面
    （因為我一週會回家，一週時間就留給他）
    （假日會一起出去，不會太遠的那種）
    可是他最近突然被他朋友說覺得他很不像有女友的人🤔他朋友說既然距離這麼近，為什麼沒有常常見面？也覺得我們平日很少約吃飯，很沒有情侶的感覺😥
    我們兩個也都很習慣這種相處方式了，但被他朋友說完後害我們兩個都在思考我們的相處方式是不是出問題了🤔
    想請問大家這樣真的很不像情侶嗎？", title: "被說不像情侶🤔", created_at: "2020-12-28T05:40:29", updated_at: "2020-12-28T05:40:29", comment_count: "1", like_count: "0", post_number: "235065630", board_id: "1", board_number: "229")

Post.create(content: "我的意思不是說男人應該打女人
      而是已經好幾次了 這邊的文章不管內容不論前因後果 只要有男人打女人的橋段  錯的就是男方 
      
      
      這不是很奇怪嗎？
      
      好像女生做什麼事都可以 怎麼激怒男生都可以
      但是男生就是不能出手打女人
      
      有這種想法的女生是不是太看的起自己了
      真覺得自己是什麼了不得的人物嗎？
      
      
      我不知道其他男生怎麼想 但我自己的原則是只要女人先動手 或是犯重大錯誤還態度囂張  我一定用拳頭還手 而且我一定會打頭 肚子  
      
      
      妳們女生真的不要超過", title: "這邊的女生都覺得男人不能打女人？", created_at: "2020-12-28T05:36:01", updated_at: "2020-12-29T05:36:01", comment_count: "3", like_count: "2", post_number: "235065592", board_id: "1", board_number: "229")

########comment

Comment.create(created_at: "2020-12-28T05:48:40", updated_at: "2020-12-28T05:48:40", content: "他朋友有問題", post_number: "235065630", post_id: "2")

Comment.create(created_at: "2020-12-28T05:41:02", updated_at: "2020-12-28T05:41:02", content: "https://i.imgur.com/RDGFl5c.jpg", post_number: "235065592", post_id: "3")

Comment.create(created_at: "2020-12-28T05:43:52", updated_at: "2020-12-28T05:43:52", content: "1.這問題跟男女無關，是法律規定，不能出手傷人。
  
  2.假設你是被他人先行暴力攻擊，你可以自衞防備。
  
  3.假設你覺得“先出手”使用暴力沒有關係，那是你的觀點，同時，遭你暴力攻擊的人，可採取法律行動。
  
  4.每個人想法不同，認為不能隨意使用暴力，是一種觀點，你同樣也無法管束到他人如何認為。", post_number: "235065592", post_id: "3")

Comment.create(created_at: "2020-12-28T05:48:42", updated_at: "2020-12-29T05:48:42", content: "男人不能打女人，但婊子可以！", post_number: "235065592", post_id: "3")

Source.create(name: "Dcard")
# Source.create(name: "PTT")
# Source.create(name: "Eney")
Board.create(name: "臺灣大學", alias: "ntu", source_id: 1)
Post.create(pid: 235076894, content: "天氣酷寒
雨滴刺人
聲聲呼喊
甘願等待

只想有人
陪我度過
今年最後一天

妳
來吧", title: "齁唷 怎麼這麼難", comment_count: 0, like_count: 1, alias: "ntu", url:"https://www.dcard.tw/f/ntu/p/235076894", author:"", token:"['天氣', '酷寒', '雨滴', '刺人', '聲聲', '呼喊', '甘願', '等待', '只', '想', '有', '人', '陪', '我', '度過', '今年', '最後', '一', '天', '妳', '來', '吧']", no_stop: "['天氣', '酷寒', '雨滴', '刺人', '聲聲', '呼喊', '甘願', '等待', '只', '想', '人', '陪', '度過', '今年', '最後', '天', '妳']", sentiment: "positive", keyword: "", clean:"天氣酷寒雨滴刺人聲聲呼喊甘願等待只想有人陪我度過今年最後一天妳來吧")
Post.create(pid: 235075835, content: "昨天下午五點左右，在總區看到一位皮膚好白 外表很像張柏芝，穿白色毛衣，

比校花小馮還漂亮

應該也是台大的，不過不知道是哪系的妹子？

有人也在學校看過她嗎？", title: "昨天在學校看到一位好像張柏芝的妹子", comment_count: 4, like_count: 4, alias: "ntu", url:"https://www.dcard.tw/f/ntu/p/235075835", author:"", token:"['昨天', '下午', '五點', '左右', '在', '總區', '看到', '一', '位', '皮膚', '好', '白', '外表', '很', '像', '張柏芝', '穿', '白色', '毛衣', '比', '校花', '小馮', '還', '漂亮', '應該', '也', '是', '台大', '的', '不過', '不', '知道', '是', '哪', '系', '的', '妹子', '有', '人', '也', '在', '學校', '看過', '她', '嗎']", no_stop: "['昨天', '下午', '五點', '左右', '總區', '看到', '位', '皮膚', '好', '外表', '張柏芝', '穿', '白色', '毛衣', '校花', '小馮', '漂亮', '應該', '台大', '知道', '系', '妹子', '人', '學校', '看過']", sentiment: "positive", keyword: "", clean:"昨天下午五點左右在總區看到一位皮膚好白外表很像張柏芝穿白色毛衣比校花小馮還漂亮應該也是台大的不過不知道是哪系的妹子有人也在學校看過她嗎")

Comment.create(cid:"a690ce69-0df7-4f0e-9bb9-f389c52dccfe",pid: 235075835,content:"總區那麼大😂",like_count:0,alias:"ntu",url:"https://www.dcard.tw/f/ntu/p/235075835",author:"",token:"['總區', '那麼', '大']",no_stop:"['總區']",sentiment:"neutral",keyword:"",clean:"總區那麼大")
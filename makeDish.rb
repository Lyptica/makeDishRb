# 昔手こずったと噂のプログラムに再挑戦。
require 'pp'

class MakeDish
  # items -> [[[name, description], amount], ...]
  # nameは一意である前提。
  @@items = []
  # recipes -> [[name, description], [[item1, amount], [item2, amount] ...], ...]
  # nameは一意である前提。
  @@recipes = []
  def initialize()
    # そもそも何するプログラムか -> 食材とレシピを入れて、作れるかどうかを確認するプログラム
    # [OK] generateSampleItems: サンプル食材を作って配列にupdate
    # [OK]showItems: 食材の一覧をls
    # [OK]generateSampleRecipes: サンプルレシピをupdate
    # [OK]showRecipes: 作ったレシピの数と内容をls
    # [OK]makeRecipe: レシピ名を指定して作れるかどうか確認

    # refillItem: itemsを探して数を補充する。

    generateSampleItems()
    generateSampleRecipes()

    showItems()
    showRecipes()
    makeRecipe("トマキュー")
    makeRecipe("トマトキューリ")
    refillItem("キューリ", 10)
    refillItem("きゅうり", 10)
    makeRecipe("トマトキューリ")
    makeRecipe("トマトキューリ")
    refillItem("トマト", 1)
    makeRecipe("トマトキューリ")
    print ("\n")
  end

  def generateItem(name, description, amount)
    @@items.push [[name, description], amount]
  end

  def generateSampleItems()
    generateItem("トマト", "赤くておいしいトマト。リコピンたっぷり！" , 5)
    generateItem("きゅうり", "サクサク食感が癖になるきゅうり。あまり栄養は無いらしい。" , 1)
  end

  def showItems()
    print "\n====== 冷蔵庫の中身を覗きます ======\n"
    @@items.each_with_index do |v,i|
      print "------ item:#{format('%02d', i+1)} ------\n"
      print "name: #{v[0][0]}\n"
      print "description: #{v[0][1]}\n"
      print "amount: #{v[1]}\n"
    end
  end

  def generateRecipe(name, description, items)
    tmp = []
    tmp.push [name, description]
    tmp.push items
    @@recipes.push tmp
  end

  def generateSampleRecipes()
    items = []
    items.push ["トマト", 3]
    items.push ["きゅうり", 2]
    generateRecipe("トマトキューリ", "トマトとキューリの絶望的なコンビネーション！", items)
  end

  def showRecipes()
    print "\n====== レシピ本を読みます ======\n"
    @@recipes.each_with_index do |v,i|
      print "------ recipe:#{format('%02d', i+1)} ------\n"
      print "name: #{v[0][0]}\n"
      print "description: #{v[0][1]}\n"
      print "require items:\n"
      v[1].each_with_index do |vv,i|
        print "> name: #{vv[0]}, amount: #{vv[1]}\n"
      end
    end
  end

  def makeRecipe(recipename)
    print "\n====== これから調理を始めます ======\n"
    isValidRecipe = false
    presentRecipe = nil
    @@recipes.each do |v|
      if recipename == v[0][0] then
        isValidRecipe = true
        presentRecipe = v[1]
      end
    end
    if isValidRecipe == true
      print "お望みのレシピが見つかりました: #{recipename}\n"
      canCook = true
      print "調理に必要な数を計算します...\n"
      presentRecipe.each do |v|
        # 持ってる数 >= レシピの数
        if showItemAmount(v[0]) >= v[1] then
          print "> #{v[0]}の数は十分です。\n"
        else
          canCook = false
          print "> #{v[0]}の数が足りません。あと#{v[1]-showItemAmount(v[0])}個用意してください。\n"
        end
      end
      if canCook == true
        # 作れるようなら消費
        print "調理を開始します...\n"
        presentRecipe.each do |v|
          idx = findItemIndex(v[0])
          print "> #{recipename} を作ったので #{v[0]} の数が #{@@items[idx][1]}個 -> #{@@items[idx][1]-v[1]}個 になりました。\n"
          @@items[idx][1] = @@items[idx][1]-v[1]
        end
        print "😁  #{recipename} が作れました。\n"
      else
        print "😨  #{recipename} は作れませんでした。\n"
      end
    else
      print "#{recipename} のレシピ名が存在しません。\n"
    end
  end

  def showItemAmount(itemname)
    idx = findItemIndex(itemname)
    amount = @@items[idx][1]
    amount = -1 if amount == nil
    return amount
  end

  def findItemIndex(itemname)
    idx = -1
    @@items.each_with_index do |v,i|
      if v[0][0] == itemname then
        idx = i
      end
    end
    return idx
  end

  def refillItem(itemname, amount)
    print "\n====== #{itemname} を補充します ======\n"
    idx = findItemIndex(itemname)
    if idx == -1 then
      print "おや、 #{itemname} は買ったことがないようですよ。\n"
    else
      print "#{itemname} を #{amount}個補充して #{@@items[idx][1]}個 -> #{@@items[idx][1]+amount}個 になりました。\n"
      @@items[idx][1] = @@items[idx][1]+amount
    end
  end

end
MakeDish.new()
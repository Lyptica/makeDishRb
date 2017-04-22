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
    # そもそも何するプログラムか？
    # -> 食材とレシピを入れて、作れるかどうかを確認するプログラム
    # generateSampleItems: サンプル食材を作って配列にupdate
    # showItems: 食材の一覧をls
    # generateSampleRecipes: サンプルレシピをupdate
    # showRecipes: 作ったレシピの数と内容をls
    # makeRecipe: レシピ名を指定して作れるかどうか確認

    generateSampleItems()
    generateSampleRecipes()

    # pp @@items
    # pp @@recipes

    showItems()
    showRecipes()
  end

  def generateItem(name, description, amount)
    @@items.push [[name, description], amount]
  end

  def generateSampleItems()
    generateItem("トマト", "赤くておいしいトマト。リコピンたっぷり！" , 1)
    generateItem("きゅうり", "サクサク食感が癖になるきゅうり。あまり栄養は無いらしい。" , 1)
  end

  def showItems()
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
    items.push ["キューリ", 2]
    generateRecipe("トマトキューリ", "トマトとキューリの絶望的なコンビネーション！", items)
  end

  def showRecipes()
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

end
MakeDish.new()
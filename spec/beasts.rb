# -*- coding: utf-8 -*-

Summoner.prepare :article do |a|
  a.name "Grölsch"
end

Summoner.prepare :list do |l|
  l.name "Weekly grocery list"
end

Summoner.prepare :item do |i|
  i.article_id Summoner.summon(:article).id
  i.list_id    Summoner.summon(:list).id
  i.price      12.0
  i.quantity   1
end

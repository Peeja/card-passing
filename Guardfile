guard :shell do
  watch("cards.rb") { `ruby cards.rb` }
end

guard :livereload, grace_period: 0 do
  watch(%r{.*\.pdf})
end

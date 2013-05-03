guard :shell do
  watch(%r{cards\.(?:rb|yml)}) { `ruby cards.rb` }
end

guard :livereload, grace_period: 0 do
  watch(%r{.*\.pdf})
end

# encoding: utf-8
假设(/^我已经访问网站地址$/) do
  visit root_path
end

那么(/^我应该看到"(.*?)"$/) do |text|
  page.should have_selector "h1", text: text
end

当(/^我单击"(.*?)"(.*?)$/) do |ob, se|
  if se == '链接'
    click_link ob
  elsif se == '按钮'
    click_button ob
  else
    raise "不明容器"
  end
end

那么(/^我应该看到"(.*?)"在"(.*?)"中$/) do |text, selector|
  expect(page).to have_selector selector, text
end
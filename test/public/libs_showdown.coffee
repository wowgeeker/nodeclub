#!
# * nodeclub - onehost plugins unit tests.
# * Copyright(c) 2012 dead-horse <dead_horse@qq.com>
# * MIT Licensed
# 

###
Module dependencies.
###
showdown = require("../../public/libs/showdown")
should = require("should")
describe "showdown xss test", ->
  it "should escape illegal url in a", ->
    text = "[illegal url][1]\n\n[1]: javascript:alert(123);"
    result = showdown.parse(text)
    result.should.equal "<p><a href=\"http://localhost.cnodejs.org:3000javascript:alert(123);\">illegal url</a></p>"
    return

  it "should escape \" in a", ->
    text = "[illegal url][1]\n\n[1]: http://baidu.com\"onmouseover='alert(123)'"
    result = showdown.parse(text)
    result.should.equal "<p><a href=\"http://localhost.cnodejs.org:3000http://baidu.com\"onmouseover='alert(123)'\">illegal url</a></p>"
    return

  it "should escape illegal url in img", ->
    text = "![illegal url][1]\n\n[1]: javascript:alert(123);"
    result = showdown.parse(text)
    result.should.equal "<p><img src=\"http://localhost.cnodejs.org:3000javascript:alert(123);\" alt=\"illegal url\" title=\"\" /></p>"
    return

  it "should escape \" in img", ->
    text = "![illegal url][1]\n\n[1]: http://baidu.com\"onmouseover='alert(123)'"
    result = showdown.parse(text)
    result.should.equal "<p><img src=\"http://localhost.cnodejs.org:3000http://baidu.com\"onmouseover='alert(123)'\" alt=\"illegal url\" title=\"\" /></p>"
    return

  return


#!
# * nodeclub - onehost plugins unit tests.
# * Copyright(c) 2012 dead-horse <dead_horse@qq.com>
# * MIT Licensed
# 

###
Module dependencies.
###
Util = require("../../libs/util")
should = require("should")
describe "libs/util", ->
  describe "escape", ->
    text1 = "<script></script> text"
    text2 = "outside:<>, inside: ```js\n<>\n```\n`<>`\n```\n<>\n```\n`span` `span`"
    text3 = "\t<>\n    <>\n"
    text4 = "abc\n\t<>\n\t<>"
    text5 = "\t<>\n\t<>\n<>"
    it "escape outside ok", ->
      result = Util.escape(text1)
      result.should.equal "&lt;script&gt;&lt;/script&gt; text"
      return

    it "not escape inside", ->
      result = Util.escape(text2)
      result.should.equal "outside:&lt;&gt;, inside: ```js\n<>\n```\n`<>`\n```\n<>\n```\n`span` `span`"
      return

    it "not escape inside block", ->
      result = Util.escape(text3)
      result.should.equal "\t<>\n    <>\n"
      return

    it "escape not inside", ->
      result = Util.escape(text4)
      result.should.equal "abc\n\t&lt;&gt;\n\t&lt;&gt;"
      return

    it "escape block next char ok", ->
      result = Util.escape(text5)
      result.should.equal "\t<>\n\t<>\n&lt;&gt;"
      return

    return

  return


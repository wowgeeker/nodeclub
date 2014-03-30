mail = require("../../services/mail")
describe "services/mail.js", ->
  describe "sendActiveMail", ->
    it "should ok", ->
      mail.sendActiveMail "shyvo1987@gmail.com", "token", "jacksontian"
      return

    return

  describe "sendResetPassMail", ->
    it "should ok", ->
      mail.sendResetPassMail "shyvo1987@gmail.com", "token", "jacksontian"
      return

    return

  xdescribe "sendAtMail", ->
    it "should ok", ->
      mail.sendAtMail()
      return

    return

  return


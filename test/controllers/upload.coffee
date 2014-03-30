upload = require("../../controllers/upload")
config = require("../../config").config
path = require("path")
fs = require("fs")
ndir = require("ndir")
exec = require("child_process").exec
should = require("should")
rewire = require("rewire")
fs.existsSync = fs.existsSync or path.existsSync
describe "controllers/upload.js", ->
  describe "uploadImage()", ->
    mockRequest = undefined
    mockLoginedRequest = undefined
    mockLoginedRequestForbidden = undefined
    beforeEach ->
      mockRequest = session:
        user:
          _id: "mock_user_id"

      mockLoginedRequest =
        session:
          user:
            _id: "mock_user_id"

        files:
          userfile:
            name: path.basename(tmpFile)
            path: tmpFile

      mockLoginedRequestForbidden =
        session:
          user:
            _id: "mock_user_id"

        files:
          userfile:
            name: "/../../" + path.basename(tmpFile)
            path: tmpFile

      return

    oldUploadDir = config.upload_dir
    tmpdirpath = path.join(path.dirname(oldUploadDir), "__testdir__")
    tmpFile = path.join(tmpdirpath, "tmp_test_file.png")
    before (done) ->
      config.upload_dir = tmpdirpath
      ndir.mkdir tmpdirpath, (err) ->
        fs.writeFileSync tmpFile, fs.readFileSync(path.join(__dirname, "../fixtures", "logo.png"))
        done err
        return

      return

    after (done) ->
      config.upload_dir = oldUploadDir
      exec "rm -rf " + tmpdirpath, (error) ->
        console.log "exec error: " + error  if error
        done error
        return

      return

    it "should forbidden when user not login", (done) ->
      upload.uploadImage {},
        send: (data) ->
          data.should.have.property "status", "forbidden"
          done()
          return
      , ->
        throw new Error("should not call this method")return

      return

    it "should failed when no file upload", (done) ->
      upload.uploadImage mockRequest,
        send: (data) ->
          data.should.have.property "status", "failed"
          data.should.have.property "message", "no file"
          done()
          return
      , ->
        throw new Error("should not call this method")return

      return

    it "should forbidden when path err", (done) ->
      upload.uploadImage mockLoginedRequestForbidden,
        send: (data) ->
          data.should.have.property "status", "forbidden"
          done()
          return
      , ->
        throw new Error("should not call this method")return

      return

    it "should upload file success", (done) ->
      upload.uploadImage mockLoginedRequest,
        send: (data) ->
          data.should.have.property "status", "success"
          data.should.have.property "url"
          data.url.should.match /^\/upload\/mock_user_id\/\d+\_tmp_test_file\.png$/
          uploadfile = path.join(tmpdirpath, data.url.replace("/upload/", ""))
          should.ok fs.existsSync(uploadfile)
          done()
          return
      , ->
        throw new Error("should not call this method")return

      return

    it "should return mock ndir.mkdir() error", (done) ->
      upload2 = rewire("../../controllers/upload")
      upload2.__set__ ndir:
        mkdir: (dir, callback) ->
          process.nextTick ->
            callback new Error("mock ndir.mkdir() error")
            return

          return

      upload2.uploadImage mockLoginedRequest,
        send: (data) ->
          throw new Error("should not call this method")return
      , (err) ->
        should.exist err
        err.message.should.equal "mock ndir.mkdir() error"
        done()
        return

      return

    it "should return mock fs.rename() error", (done) ->
      upload3 = rewire("../../controllers/upload")
      upload3.__set__ fs:
        rename: (from, to, callback) ->
          process.nextTick ->
            callback new Error("mock fs.rename() error")
            return

          return

      upload3.uploadImage mockLoginedRequest,
        send: (data) ->
          throw new Error("should not call this method")return
      , (err) ->
        should.exist err
        err.message.should.equal "mock fs.rename() error"
        done()
        return

      return

    return

  return


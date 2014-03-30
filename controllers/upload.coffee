fs = require("fs")
path = require("path")
ndir = require("ndir")
config = require("../config").config
exports.uploadImage = (req, res, next) ->
  if not req.session or not req.session.user
    res.send status: "forbidden"
    return
  file = req.files and req.files.userfile
  unless file
    res.send
      status: "failed"
      message: "no file"

    return
  uid = req.session.user._id.toString()
  userDir = path.join(config.upload_dir, uid)
  ndir.mkdir userDir, (err) ->
    return next(err)  if err
    filename = Date.now() + "_" + file.name
    savepath = path.resolve(path.join(userDir, filename))
    return res.send(status: "forbidden")  if savepath.indexOf(path.resolve(userDir)) isnt 0
    fs.rename file.path, savepath, (err) ->
      return next(err)  if err
      url = "/upload/" + uid + "/" + encodeURIComponent(filename)
      res.send
        status: "success"
        url: url

      return

    return

  return

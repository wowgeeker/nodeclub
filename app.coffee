#!
# * nodeclub - app.js
# 

###
Module dependencies.
###
fs = require("fs")
path = require("path")
Loader = require("loader")
express = require("express")
ndir = require("ndir")
config = require("./config").config
passport = require("passport")
Models = require("./models")
User = Models.User
GitHubStrategy = require("passport-github").Strategy
githubStrategyMiddleware = require("./middlewares/github_strategy")
routes = require("./routes")
auth = require("./middlewares/auth")
maxAge = 3600000 * 24 * 30
staticDir = path.join(__dirname, "public")

# assets
assets = {}
if config.mini_assets
  try
    assets = JSON.parse(fs.readFileSync(path.join(__dirname, "assets.json")))
  catch e
    console.log "You must execute `make build` before start app when mini_assets is true."
    throw e

# host: http://127.0.0.1
urlinfo = require("url").parse(config.host)
config.hostname = urlinfo.hostname or config.host
config.upload_dir = config.upload_dir or path.join(__dirname, "public", "user_data", "images")

# ensure upload dir exists
ndir.mkdir config.upload_dir, (err) ->
  throw err  if err
  return

app = express.createServer()

# configuration in all env
app.set "view engine", "html"
app.set "views", path.join(__dirname, "views")
app.register ".html", require("ejs")
app.use express.bodyParser(uploadDir: config.upload_dir)
app.use express.methodOverride()
app.use express.cookieParser()
app.use express.session(secret: config.session_secret)
app.use passport.initialize()

# custom middleware
app.use require("./controllers/sign").auth_user
app.use auth.blockUser()
app.use "/upload/", express.static(config.upload_dir,
  maxAge: maxAge
)

# old image url: http://host/user_data/images/xxxx
app.use "/user_data/", express.static(path.join(__dirname, "public", "user_data"),
  maxAge: maxAge
)
if config.debug
  app.use "/public", express.static(staticDir)
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )
else
  app.use (req, res, next) ->
    csrf = express.csrf()
    
    # ignore upload image
    return next()  if req.body and req.body.user_action is "upload_image"
    csrf req, res, next
    return

  app.use "/public", express.static(staticDir,
    maxAge: maxAge
  )
  app.use express.errorHandler()
  app.set "view cache", true

# set static, dynamic helpers
app.helpers
  config: config
  Loader: Loader
  assets: assets

app.dynamicHelpers require("./common/render_helpers")
if process.env.NODE_ENV isnt "test"
  
  # plugins
  plugins = config.plugins or []
  i = 0
  l = plugins.length

  while i < l
    p = plugins[i]
    app.use require("./plugins/" + p.name)(p.options)
    i++

# github oauth
passport.serializeUser (user, done) ->
  done null, user
  return

passport.deserializeUser (user, done) ->
  done null, user
  return

passport.use new GitHubStrategy(config.GITHUB_OAUTH, githubStrategyMiddleware)

# routes
routes app
if process.env.NODE_ENV isnt "test"
  app.listen config.port
  console.log "NodeClub listening on port %d in %s mode", config.port, app.settings.env
  console.log "God bless love...."
  console.log "You can debug your app with http://" + config.hostname + ":" + config.port
module.exports = app

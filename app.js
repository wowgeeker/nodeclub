// Generated by CoffeeScript 1.4.0

/*
Module dependencies.
*/


(function() {
  var GitHubStrategy, Loader, Models, User, app, assets, auth, config, express, fs, githubStrategyMiddleware, i, l, maxAge, ndir, p, passport, path, plugins, routes, staticDir, urlinfo;

  fs = require("fs");

  path = require("path");

  Loader = require("loader");

  express = require("express");

  ndir = require("ndir");

  config = require("./config").config;

  passport = require("passport");

  Models = require("./models");

  User = Models.User;

  GitHubStrategy = require("passport-github").Strategy;

  githubStrategyMiddleware = require("./middlewares/github_strategy");

  routes = require("./routes");

  auth = require("./middlewares/auth");

  maxAge = 3600000 * 24 * 30;

  staticDir = path.join(__dirname, "public");

  assets = {};

  if (config.mini_assets) {
    try {
      assets = JSON.parse(fs.readFileSync(path.join(__dirname, "assets.json")));
    } catch (e) {
      console.log("You must execute `make build` before start app when mini_assets is true.");
      throw e;
    }
  }

  urlinfo = require("url").parse(config.host);

  config.hostname = urlinfo.hostname || config.host;

  config.upload_dir = config.upload_dir || path.join(__dirname, "public", "user_data", "images");

  ndir.mkdir(config.upload_dir, function(err) {
    if (err) {
      throw err;
    }
  });

  app = express.createServer();

  app.set("view engine", "html");

  app.set("views", path.join(__dirname, "views"));

  app.register(".html", require("ejs"));

  app.use(express.bodyParser({
    uploadDir: config.upload_dir
  }));

  app.use(express.methodOverride());

  app.use(express.cookieParser());

  app.use(express.session({
    secret: config.session_secret
  }));

  app.use(passport.initialize());

  app.use(require("./controllers/sign").auth_user);

  app.use(auth.blockUser());

  app.use("/upload/", express["static"](config.upload_dir, {
    maxAge: maxAge
  }));

  app.use("/user_data/", express["static"](path.join(__dirname, "public", "user_data"), {
    maxAge: maxAge
  }));

  if (config.debug) {
    app.use("/public", express["static"](staticDir));
    app.use(express.errorHandler({
      dumpExceptions: true,
      showStack: true
    }));
  } else {
    app.use(function(req, res, next) {
      var csrf;
      csrf = express.csrf();
      if (req.body && req.body.user_action === "upload_image") {
        return next();
      }
      csrf(req, res, next);
    });
    app.use("/public", express["static"](staticDir, {
      maxAge: maxAge
    }));
    app.use(express.errorHandler());
    app.set("view cache", true);
  }

  app.helpers({
    config: config,
    Loader: Loader,
    assets: assets
  });

  app.dynamicHelpers(require("./common/render_helpers"));

  if (process.env.NODE_ENV !== "test") {
    plugins = config.plugins || [];
    i = 0;
    l = plugins.length;
    while (i < l) {
      p = plugins[i];
      app.use(require("./plugins/" + p.name)(p.options));
      i++;
    }
  }

  passport.serializeUser(function(user, done) {
    done(null, user);
  });

  passport.deserializeUser(function(user, done) {
    done(null, user);
  });

  passport.use(new GitHubStrategy(config.GITHUB_OAUTH, githubStrategyMiddleware));

  routes(app);

  if (process.env.NODE_ENV !== "test") {
    app.listen(config.port);
    console.log("NodeClub listening on port %d in %s mode", config.port, app.settings.env);
    console.log("God bless love....");
    console.log("You can debug your app with http://" + config.hostname + ":" + config.port);
  }

  module.exports = app;

}).call(this);

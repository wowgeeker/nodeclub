mysql = require("mysql")
client = mysql.createClient()
client.host = "127.0.0.1"
client.user = "user"
client.password = "pwd"
client.query "USE wordpress"
sql = "select id, post_title, post_status, post_type from nodejs_wp_posts where post_status=\"publish\""
client.query sql, (err, rows) ->
  console.log JSON.stringify(rows)
  console.log "done"
  return


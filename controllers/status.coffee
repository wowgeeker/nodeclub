# 用于网络监控
exports.status = (req, res, next) ->
  res.json
    status: "success"
    now: new Date()

  return

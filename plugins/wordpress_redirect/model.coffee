mongoose = require("mongoose")
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
PostToTopicSchema = new Schema(
  _id:
    type: Number

  topic_id:
    type: ObjectId
)
mongoose.model "PostToTopic", PostToTopicSchema
exports.PostToTopic = mongoose.model("PostToTopic")

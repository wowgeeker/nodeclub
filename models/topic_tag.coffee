mongoose = require("mongoose")
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
TopicTagSchema = new Schema(
  topic_id:
    type: ObjectId

  tag_id:
    type: ObjectId

  create_at:
    type: Date
    default: Date.now
)
mongoose.model "TopicTag", TopicTagSchema

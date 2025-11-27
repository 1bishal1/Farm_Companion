const mongoose = require("mongoose");
const config = require("./config");

const db = {};

db.connect = async () => {
  try {
    if (!config.MONGODB_URI) {
      throw new Error("MONGODB_URI is not set");
    }

    await mongoose.connect(config.MONGODB_URI, {
      autoIndex: true,
    });

    console.log("MongoDB connected");
  } catch (error) {
    console.error("MongoDB connection error:", error.message);
    process.exit(1);
  }
};

db.disconnect = async () => {
  try {
    await mongoose.connection.close(false);
    console.log("MongoDB disconnected");
  } catch (error) {
    console.error("MongoDB disconnection error:", error.message);
  }
};

module.exports = db;


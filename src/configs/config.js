const dotenv = require("dotenv");

dotenv.config();

const config = {
  PORT: process.env.PORT || 5000,
  MONGODB_URI: process.env.MONGODB_URI || "mongodb://127.0.0.1:27017/databse_farm_companion",
  JWT_SECRET: process.env.JWT_SECRET || "fallback-secret",
  JWT_EXPIRATION: process.env.JWT_EXPIRATION || "30d",
};

module.exports = config;


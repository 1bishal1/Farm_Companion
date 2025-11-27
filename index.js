const express = require("express");
const cors = require("cors");

const config = require("./src/configs/config");
const db = require("./src/configs/db");

const authRoutes = require("./src/routes/authRoutes");
const animalRoutes = require("./src/routes/animalRoutes");
const userRoutes = require("./src/routes/userRoutes");


const app = express();

app.use(cors());
app.use(express.json());

db.connect();

app.get("/health", (_req, res) => {
  res.json({ status: "ok", service: "Farm Companion API" });
});

app.use("/api/auth", authRoutes);
app.use("/api/animals", animalRoutes);
app.use("/api/users", userRoutes);


const port = config.PORT;

app.listen(port, () => {
  console.log(`Farm Companion API is running on port ${port}`);
});


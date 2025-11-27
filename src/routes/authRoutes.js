const express = require("express");
const { registerFarmer, loginFarmer } = require("../controllers/authController");

const router = express.Router();

router.post("/signup", registerFarmer);
router.post("/login", loginFarmer);

module.exports = router;


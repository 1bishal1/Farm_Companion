const express = require("express");
const router = express.Router();

const {
  createAnimal,
  getAllAnimals,
  getMyAnimals,
} = require("../controllers/animalController");
const requireAuth = require("../middleware/authMiddleware");

// POST /api/animals/addanimal -> create a new animal entry for logged-in user
router.post("/addanimal", requireAuth, createAnimal);

// GET /api/animals/mine -> list animals for logged-in user
router.get("/mine", requireAuth, getMyAnimals);

// GET /api/animals/all -> list all animals (admin / debug)
router.get("/all", getAllAnimals);

module.exports = router;


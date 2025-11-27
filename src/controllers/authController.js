const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const User = require("../models/userModel");
const config = require("../configs/config");

const sanitizeUser = (userDoc) => {
  const { password, __v, ...safeUser } = userDoc.toObject();
  return safeUser;
};

const registerFarmer = async (req, res) => {
  try {
    const { fullName, farmName, email, phoneNumber, password, confirmPassword } =
      req.body;

    if (!fullName || !email || !phoneNumber || !password) {
      return res
        .status(400)
        .json({ error: "fullName, email, phoneNumber, and password are required" });
    }

    if (password.length < 8) {
      return res
        .status(400)
        .json({ error: "Password must be at least 8 characters long" });
    }

    if (confirmPassword && confirmPassword !== password) {
      return res.status(400).json({ error: "Passwords do not match" });
    }

    const normalizedEmail = email.toLowerCase().trim();

    const [existingEmail, existingPhone] = await Promise.all([
      User.findOne({ email: normalizedEmail }),
      User.findOne({ phoneNumber: phoneNumber.trim() }),
    ]);

    if (existingEmail) {
      return res.status(409).json({ error: "Email already registered" });
    }

    if (existingPhone) {
      return res.status(409).json({ error: "Phone number already registered" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await User.create({
      fullName: fullName.trim(),
      farmName: farmName ? farmName.trim() : undefined,
      email: normalizedEmail,
      phoneNumber: phoneNumber.trim(),
      password: hashedPassword,
    });

    res
      .status(201)
      .json({ message: "Account created successfully", user: sanitizeUser(user) });
  } catch (error) {
    console.error("Error during registration:", error);
    res.status(500).json({ error: "Server error. Please try again later." });
  }
};

const loginFarmer = async (req, res) => {
  try {
    const { identifier, password } = req.body;

    if (!identifier || !password) {
      return res.status(400).json({ error: "identifier and password are required" });
    }

    const normalizedIdentifier = identifier.trim().toLowerCase();

    const user = await User.findOne({
      $or: [{ email: normalizedIdentifier }, { phoneNumber: identifier.trim() }],
    });

    if (!user) {
      return res.status(400).json({ error: "Invalid credentials" });
    }

    const isValid = await bcrypt.compare(password, user.password);

    if (!isValid) {
      return res.status(400).json({ error: "Invalid credentials" });
    }

    if (!config.JWT_SECRET) {
      console.warn("JWT_SECRET missing; using fallback secret");
    }

    const token = jwt.sign({ id: user._id }, config.JWT_SECRET, {
      expiresIn: config.JWT_EXPIRATION,
    });

    res.status(200).json({
      message: "Login successful",
      token,
      user: sanitizeUser(user),
    });
  } catch (error) {
    console.error("Error during login:", error);
    res.status(500).json({ error: "Server error. Please try again later." });
  }
};

module.exports = {
  registerFarmer,
  loginFarmer,
};


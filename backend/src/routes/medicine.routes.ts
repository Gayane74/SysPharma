import express from "express";
import { getMedicines, createMedicine } from "../controllers/medicine.controller";
import { protect } from "../middlewares/auth.middleware";

const router = express.Router();
router.get("/", protect, getMedicines);
router.post("/", protect, createMedicine);
export default router;

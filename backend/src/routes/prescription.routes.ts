import express from "express";
import { getPrescriptions, createPrescription } from "../controllers/prescription.controller";
import { protect } from "../middlewares/auth.middleware";

const router = express.Router();
router.get("/", protect, getPrescriptions);
router.post("/", protect, createPrescription);
export default router;

import express from "express";
import { getBatches, createBatch } from "../controllers/batch.controller";
import { protect } from "../middlewares/auth.middleware";

const router = express.Router();
router.get("/", protect, getBatches);
router.post("/", protect, createBatch);
export default router;

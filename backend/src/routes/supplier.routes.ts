import express from "express";
import { getSuppliers, createSupplier } from "../controllers/supplier.controller";
import { protect } from "../middlewares/auth.middleware";

const router = express.Router();
router.get("/", protect, getSuppliers);
router.post("/", protect, createSupplier);
export default router;

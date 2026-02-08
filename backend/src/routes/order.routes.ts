import express from "express";
import { getOrders, createOrder } from "../controllers/order.controller";
import { protect } from "../middlewares/auth.middleware";

const router = express.Router();
router.get("/", protect, getOrders);
router.post("/", protect, createOrder);
export default router;

import { Request, Response } from "express";
import { AppDataSource } from "../config/db";
import { Order } from "../entities/Order";

export const getOrders = async (_req: Request, res: Response) => {
  const repo = AppDataSource.getRepository(Order);
  res.json(await repo.find());
};

export const createOrder = async (req: Request, res: Response) => {
  const repo = AppDataSource.getRepository(Order);
  const order = repo.create(req.body);
  await repo.save(order);
  res.status(201).json(order);
};

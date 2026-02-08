import { Request, Response } from "express";
import { AppDataSource } from "../config/db";
import { Sale } from "../entities/Sale";

export const getSales = async (_req: Request, res: Response) => {
  const repo = AppDataSource.getRepository(Sale);
  res.json(await repo.find());
};

export const createSale = async (req: Request, res: Response) => {
  const repo = AppDataSource.getRepository(Sale);
  const sale = repo.create(req.body);
  await repo.save(sale);
  res.status(201).json(sale);
};

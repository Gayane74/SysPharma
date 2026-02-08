import { Request, Response } from "express";
import { AppDataSource } from "../config/db";
import { Supplier } from "../entities/Supplier";

export const getSuppliers = async (_req: Request, res: Response) => {
  const repo = AppDataSource.getRepository(Supplier);
  res.json(await repo.find());
};

export const createSupplier = async (req: Request, res: Response) => {
  const repo = AppDataSource.getRepository(Supplier);
  const supplier = repo.create(req.body);
  await repo.save(supplier);
  res.status(201).json(supplier);
};

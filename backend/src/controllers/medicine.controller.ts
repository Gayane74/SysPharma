import { Request, Response } from "express";
import { AppDataSource } from "../config/db";
import { Medicine } from "../entities/Medicine";

export const getMedicines = async (_req: Request, res: Response) => {
  const repo = AppDataSource.getRepository(Medicine);
  res.json(await repo.find());
};

export const createMedicine = async (req: Request, res: Response) => {
  const repo = AppDataSource.getRepository(Medicine);
  const medicine = repo.create(req.body);
  await repo.save(medicine);
  res.status(201).json(medicine);
};

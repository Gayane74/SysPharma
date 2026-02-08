import { Request, Response } from "express";
import { AppDataSource } from "../config/db";
import { Batch } from "../entities/Batch";

export const getBatches = async (_req: Request, res: Response) => {
  const repo = AppDataSource.getRepository(Batch);
  res.json(await repo.find());
};

export const createBatch = async (req: Request, res: Response) => {
  const repo = AppDataSource.getRepository(Batch);
  const batch = repo.create(req.body);
  await repo.save(batch);
  res.status(201).json(batch);
};

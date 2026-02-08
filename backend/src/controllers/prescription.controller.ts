import { Request, Response } from "express";
import { AppDataSource } from "../config/db";
import { Prescription } from "../entities/Prescription";

export const getPrescriptions = async (_req: Request, res: Response) => {
  const repo = AppDataSource.getRepository(Prescription);
  res.json(await repo.find());
};

export const createPrescription = async (req: Request, res: Response) => {
  const repo = AppDataSource.getRepository(Prescription);
  const pres = repo.create(req.body);
  await repo.save(pres);
  res.status(201).json(pres);
};

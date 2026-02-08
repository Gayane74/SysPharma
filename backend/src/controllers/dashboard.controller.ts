import { Request, Response } from "express";
import { AppDataSource } from "../config/db";
import { Medicine } from "../entities/Medicine";
import { Batch } from "../entities/Batch";
import { Sale } from "../entities/Sale";

export const getDashboardData = async (_req: Request, res: Response) => {
  const medicineRepo = AppDataSource.getRepository(Medicine);
  const batchRepo = AppDataSource.getRepository(Batch);
  const saleRepo = AppDataSource.getRepository(Sale);

  const totalMedicines = await medicineRepo.count();
  const expiredBatches = await batchRepo.count({
    where: { expiryDate: new Date() },
  });
  const totalSales = await saleRepo.count();

  res.json({ totalMedicines, expiredBatches, totalSales });
};

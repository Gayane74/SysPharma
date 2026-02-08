import { Request, Response } from "express";
import { AppDataSource } from "../config/db";
import { User } from "../entities/User";
import bcrypt from "bcryptjs";
import { generateToken } from "../utils/generateToken";

export const login = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  const userRepo = AppDataSource.getRepository(User);
  const user = await userRepo.findOne({ where: { email } });

  if (!user) return res.status(401).json({ message: "Invalid credentials" });

  const isMatch = await bcrypt.compare(password, user.password);
  if (!isMatch) return res.status(401).json({ message: "Invalid credentials" });

  res.json({
    token: generateToken(user.id, user.role),
    role: user.role,
    name: user.name,
  });
};

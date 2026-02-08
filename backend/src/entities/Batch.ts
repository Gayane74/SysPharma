import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity()
export class Batch {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column()
  medicineId!: number;

  @Column()
  batchNumber!: string;

  @Column()
  expiryDate!: Date;

  @Column("int")
  quantity!: number;
}

import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity()
export class Order {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column()
  supplierId!: number;

  @Column()
  medicineId!: number;

  @Column("int")
  quantity!: number;

  @Column({ default: "pending" })
  status!: "pending" | "delivered";
}

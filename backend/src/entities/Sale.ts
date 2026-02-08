import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity()
export class Sale {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column()
  medicineId!: number;

  @Column("int")
  quantity!: number;

  @Column("float")
  totalPrice!: number;

  @Column()
  hasPrescription!: boolean;

  @Column({ type: "timestamp", default: () => "CURRENT_TIMESTAMP" })
  date!: Date;
}

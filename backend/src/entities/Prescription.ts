import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity()
export class Prescription {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column()
  patientName!: string;

  @Column()
  medicineId!: number;

  @Column("int")
  quantity!: number;

  @Column({ type: "timestamp", default: () => "CURRENT_TIMESTAMP" })
  date!: Date;
}

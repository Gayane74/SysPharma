import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity()
export class Medicine {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column()
  name!: string;

  @Column()
  category!: string;

  @Column("float")
  purchasePrice!: number;

  @Column("float")
  salePrice!: number;

  @Column("int")
  totalQuantity!: number;
}

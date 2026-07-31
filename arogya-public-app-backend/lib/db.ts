import { Pool } from "pg";

const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "arogya_smc",
  password: "Stavan@1234",
  port: 5432,
});

export default pool;
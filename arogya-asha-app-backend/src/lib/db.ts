// lib/db.ts
import { Pool } from 'pg';

declare global {
  // eslint-disable-next-line no-var
  var pgPool: Pool | undefined;
}

const pool =
  globalThis.pgPool ??
  new Pool({
    user: process.env.POSTGRES_USER ?? process.env.DB_USER ?? 'postgres',
    host: process.env.POSTGRES_HOST ?? process.env.DB_HOST ?? 'localhost',
    database: process.env.POSTGRES_DB ?? process.env.DB_NAME ?? 'arogya_smc',
    password: process.env.POSTGRES_PASSWORD ?? process.env.DB_PASSWORD ?? '123',
    port: parseInt(process.env.POSTGRES_PORT ?? process.env.DB_PORT ?? '5432', 10),
    max: 20,
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 2000,
  });

if (!globalThis.pgPool) {
  globalThis.pgPool = pool;
}

export const query = async (text: string, params?: any[]) => {
  const start = Date.now();
  try {
    const res = await pool.query(text, params);
    const duration = Date.now() - start;
    console.log('Executed query', { text, duration, rows: res.rowCount });
    return res;
  } catch (err: any) {
    console.error('Database query error:', err?.message ?? err);
    throw err;
  }
};

export default pool;

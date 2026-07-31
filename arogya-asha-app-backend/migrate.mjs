import pg from 'pg';
import fs from 'fs';

const envFile = fs.readFileSync('.env.local', 'utf8');
for (const line of envFile.split('\n')) {
  if (line.trim().startsWith('#') || !line.includes('=')) continue;
  const [key, ...rest] = line.split('=');
  process.env[key.trim()] = rest.join('=').trim().replace(/^"|"$/g, '');
}

const pool = new pg.Pool({
  user: process.env.POSTGRES_USER,
  host: process.env.POSTGRES_HOST,
  database: process.env.POSTGRES_DB,
  password: process.env.POSTGRES_PASSWORD,
  port: parseInt(process.env.POSTGRES_PORT || '5432'),
});

async function main() {
  const sql = fs.readFileSync('add_client_ids.sql', 'utf8');
  console.log('Running migration...');
  await pool.query(sql);
  console.log('Migration complete.');
  await pool.end();
}

main().catch(console.error);

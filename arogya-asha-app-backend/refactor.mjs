import fs from 'fs';
import path from 'path';

// 1. Fix middleware.ts
const mwPath = 'middleware.ts';
let mwCode = fs.readFileSync(mwPath, 'utf8');
mwCode = mwCode.replace(
  `const PUBLIC_ROUTES = ['/api/public', '/api/health'];`,
  `const PUBLIC_ROUTES = ['/api/public', '/api/health', '/api/advisories', '/api/facilities/nearby'];`
);
fs.writeFileSync(mwPath, mwCode);

// 2. Fix imports across the app
const filesWithBadImports = [
  'app/api/wards/route.ts',
  'app/api/visits/route.ts',
  'app/api/vaccinations/route.ts',
  'app/api/growth-measurements/route.ts',
  'app/api/family-members/route.ts',
  'app/api/facilities/route.ts',
  'app/api/beneficiaries/[id]/route.ts',
  'app/api/beneficiaries/route.ts'
];

for (const file of filesWithBadImports) {
  if (fs.existsSync(file)) {
    let code = fs.readFileSync(file, 'utf8');
    code = code.replace(/from\s+['"]\.\.\/\.\.\/\.\.\/src\/lib\/db['"]/g, "from '@/lib/db'");
    code = code.replace(/from\s+['"]\.\.\/\.\.\/\.\.\/\.\.\/lib\/db['"]/g, "from '@/lib/db'");
    fs.writeFileSync(file, code);
  }
}

// 3. Fix POST routes for client_id insertion and foreign key mapping
// a. app/api/beneficiaries/route.ts
const benPath = 'app/api/beneficiaries/route.ts';
if (fs.existsSync(benPath)) {
  let benCode = fs.readFileSync(benPath, 'utf8');
  benCode = benCode.replace(
    /const {\s*family_name,/,
    "const { \n      id,\n      family_name,"
  );
  benCode = benCode.replace(
    /total_members, pregnant_women_count, children_count, high_risk_flag\r?\n\s*\) VALUES \(\$1, \$2, \$3, \$4, \$5, \$6, \$7, \$8, \$9\) RETURNING \*/,
    "total_members, pregnant_women_count, children_count, high_risk_flag, client_id\n      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING *"
  );
  benCode = benCode.replace(
    /total_members \|\| 1, pregnant_women_count \|\| 0, children_count \|\| 0, high_risk_flag \|\| false\r?\n\s*\]/,
    "total_members || 1, pregnant_women_count || 0, children_count || 0, high_risk_flag || false,\n        id || null\n      ]"
  );
  fs.writeFileSync(benPath, benCode);
}

// b. app/api/beneficiaries/children/route.ts
const childrenPath = 'app/api/beneficiaries/children/route.ts';
if (fs.existsSync(childrenPath)) {
  let chCode = fs.readFileSync(childrenPath, 'utf8');
  // We need to fetch internal family_id
  chCode = chCode.replace(
    /const result = await query\(/,
    `// Resolve family UUID to internal ID
    const benRes = await query('SELECT id FROM beneficiaries WHERE client_id = $1', [family_id]);
    const actualFamilyId = benRes.rows.length > 0 ? benRes.rows[0].id : family_id;

    const result = await query(`
  );
  chCode = chCode.replace(
    /INSERT INTO children \(id, family_id, name, date_of_birth, gender, blood_group, nutrition_status\)/,
    "INSERT INTO children (client_id, family_id, name, date_of_birth, gender, blood_group, nutrition_status)"
  );
  chCode = chCode.replace(
    /ON CONFLICT \(id\) DO UPDATE SET/,
    "ON CONFLICT (client_id) DO UPDATE SET"
  );
  chCode = chCode.replace(
    /\[id, family_id, name,/,
    "[id, actualFamilyId, name,"
  );
  fs.writeFileSync(childrenPath, chCode);
}

// Note: I could script visits, vaccinations, etc. but I will check their contents first if needed.
console.log('Refactoring complete.');

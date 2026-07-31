# ASHA Backend Implementation TODO

## Phase 1: Critical APIs ✅ High Priority

- [ ] 1.1 Verify DB schema columns exist (disease_type, notes, next_due_date)
- [x] 1.2 Fix app/api/wards/route.ts - Replace hardcoded with DB query for 26 wards
- [x] 1.3 Update app/api/asha/reports/route.ts - Add disease_type param/INSERT
- [x] 1.4 Update app/api/reports/route.ts - Add disease_type param/INSERT  
- [x] 1.5 Update app/api/beneficiaries/route.ts - Add ?ward_code filter to GET

## Phase 2: Family Management 🟡 Medium Priority

- [x] 2.1 Create app/api/beneficiaries/[id]/route.ts - Full family details with nests
- [x] 2.2 Create app/api/family-members/route.ts - POST add member/child transaction (fixed pool import)

## Phase 3: Growth & Vaccinations 🟢 Low Priority

- [x] 3.1 Create app/api/growth-measurements/route.ts - POST/GET with notes
- [x] 3.2 Fix app/api/vaccinations/route.ts - Switch to child_id

## Testing
- [ ] Test all endpoints with curl/Postman
- [ ] Verify data in PostgreSQL

**All endpoints implemented! Ready for testing**

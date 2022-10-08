SELECT 
  c.company_code, c.founder, 
  COUNT(DISTINCT l.lead_manager_code), 
  COUNT(DISTINCT s.senior_manager_code), 
  COUNT(DISTINCT m.manager_code), 
  COUNT(DISTINCT e.employee_code) 
FROM Company c 
JOIN lead_manager l ON c.company_code = l.company_code 
JOIN senior_manager s ON l.company_code = s.company_code 
JOIN manager m ON s.company_code = m.company_code 
JOIN Employee E ON m.company_code = e.company_code 
GROUP BY c.company_code, c.founder 
ORDER BY c.company_code;

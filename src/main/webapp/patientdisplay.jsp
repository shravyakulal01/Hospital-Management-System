<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Patient" %>
<html>
<head>
<title>Patient List</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    min-height: 100vh;
    padding: 20px;
    position: relative;
}

body::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: 
        radial-gradient(circle at 25% 25%, rgba(59, 130, 246, 0.1) 0%, transparent 40%),
        radial-gradient(circle at 75% 75%, rgba(139, 69, 19, 0.05) 0%, transparent 40%);
    pointer-events: none;
    z-index: 0;
}

.container {
    max-width: 1400px;
    margin: 0 auto;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    border-radius: 20px;
    padding: 40px;
    box-shadow: 
        0 25px 50px rgba(0, 0, 0, 0.1),
        0 0 0 1px rgba(255, 255, 255, 0.3);
    position: relative;
    z-index: 1;
    animation: slideUp 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

h2 {
    color: #1f2937;
    font-size: 2.5rem;
    font-weight: 700;
    text-align: center;
    margin-bottom: 40px;
    position: relative;
    background: linear-gradient(135deg, #1f2937, #3b82f6);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    letter-spacing: -0.5px;
}

h2::after {
    content: '';
    position: absolute;
    bottom: -15px;
    left: 50%;
    transform: translateX(-50%);
    width: 100px;
    height: 4px;
    background: linear-gradient(90deg, #3b82f6, #1f2937);
    border-radius: 2px;
}

.no-patients {
    text-align: center;
    padding: 60px 20px;
    background: linear-gradient(135deg, #fef3c7, #fde68a);
    border-radius: 16px;
    margin: 40px 0;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
    border: 1px solid rgba(251, 191, 36, 0.2);
}

.no-patients p {
    font-size: 1.5rem;
    color: #92400e;
    font-weight: 600;
    margin: 0;
}

.table-container {
    overflow: hidden;
    border-radius: 16px;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
    margin: 30px 0;
    background: white;
    border: 1px solid rgba(0, 0, 0, 0.05);
}

.table-wrapper {
    overflow-x: auto;
    max-height: 70vh;
}

table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    font-size: 14px;
}

th {
    background: linear-gradient(135deg, #1f2937, #374151);
    color: white;
    padding: 20px 16px;
    text-align: left;
    font-weight: 600;
    letter-spacing: 0.5px;
    text-transform: uppercase;
    font-size: 13px;
    position: sticky;
    top: 0;
    z-index: 10;
    border-bottom: 3px solid #3b82f6;
}

th:first-child {
    border-top-left-radius: 0;
}

th:last-child {
    border-top-right-radius: 0;
}

td {
    padding: 16px;
    border-bottom: 1px solid #e5e7eb;
    color: #374151;
    font-weight: 500;
    vertical-align: middle;
    transition: all 0.2s ease;
}

tr:hover td {
    background: linear-gradient(135deg, #f8fafc, #f1f5f9);
    color: #1f2937;
}

tr:nth-child(even) td {
    background: rgba(249, 250, 251, 0.5);
}

tr:nth-child(even):hover td {
    background: linear-gradient(135deg, #f8fafc, #f1f5f9);
}

.action-btn {
    display: inline-block;
    padding: 8px 16px;
    margin: 2px;
    text-decoration: none;
    border-radius: 8px;
    font-weight: 600;
    font-size: 12px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    border: 2px solid transparent;
    position: relative;
    overflow: hidden;
}

.action-btn::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.2);
    transition: left 0.3s;
}

.action-btn:hover::before {
    left: 100%;
}

.edit-btn {
    background: linear-gradient(135deg, #059669, #047857);
    color: white;
    box-shadow: 0 4px 12px rgba(5, 150, 105, 0.3);
}

.edit-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(5, 150, 105, 0.4);
    background: linear-gradient(135deg, #047857, #065f46);
}

.delete-btn {
    background: linear-gradient(135deg, #dc2626, #b91c1c);
    color: white;
    box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
}

.delete-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(220, 38, 38, 0.4);
    background: linear-gradient(135deg, #b91c1c, #991b1b);
}

.navigation-links {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 40px;
    flex-wrap: wrap;
}

.nav-link {
    display: inline-flex;
    align-items: center;
    padding: 16px 24px;
    text-decoration: none;
    color: white;
    background: linear-gradient(135deg, #3b82f6, #2563eb);
    border-radius: 12px;
    font-weight: 600;
    font-size: 14px;
    transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    box-shadow: 0 6px 20px rgba(59, 130, 246, 0.3);
    border: 2px solid transparent;
    position: relative;
    overflow: hidden;
}

.nav-link::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.1);
    transition: left 0.4s;
}

.nav-link:hover::before {
    left: 100%;
}

.nav-link:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 30px rgba(59, 130, 246, 0.4);
    background: linear-gradient(135deg, #2563eb, #1d4ed8);
    border-color: rgba(255, 255, 255, 0.2);
}

.nav-link:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.4);
}

/* Enhanced responsive design */
@media (max-width: 1200px) {
    .container {
        padding: 30px 20px;
    }
    
    table {
        font-size: 13px;
    }
    
    th, td {
        padding: 12px 10px;
    }
    
    .action-btn {
        padding: 6px 12px;
        font-size: 11px;
    }
}

@media (max-width: 768px) {
    body {
        padding: 15px;
    }
    
    .container {
        padding: 25px 15px;
        border-radius: 16px;
    }
    
    h2 {
        font-size: 2rem;
        margin-bottom: 30px;
    }
    
    table {
        font-size: 12px;
    }
    
    th, td {
        padding: 10px 8px;
    }
    
    .navigation-links {
        flex-direction: column;
        align-items: center;
        gap: 15px;
    }
    
    .nav-link {
        width: 100%;
        max-width: 300px;
        justify-content: center;
    }
}

@media (max-width: 600px) {
    h2 {
        font-size: 1.8rem;
    }
    
    .table-wrapper {
        font-size: 11px;
    }
    
    th {
        padding: 12px 6px;
        font-size: 11px;
    }
    
    td {
        padding: 10px 6px;
    }
    
    .action-btn {
        padding: 5px 8px;
        font-size: 10px;
        margin: 1px;
    }
}

/* Loading states and animations */
.container {
    animation: containerLoad 0.8s ease-out;
}

@keyframes containerLoad {
    0% {
        opacity: 0;
        transform: scale(0.95) translateY(20px);
    }
    100% {
        opacity: 1;
        transform: scale(1) translateY(0);
    }
}

/* Table row animations */
tr {
    animation: rowSlide 0.3s ease-out backwards;
}

tr:nth-child(1) { animation-delay: 0.1s; }
tr:nth-child(2) { animation-delay: 0.15s; }
tr:nth-child(3) { animation-delay: 0.2s; }
tr:nth-child(4) { animation-delay: 0.25s; }
tr:nth-child(5) { animation-delay: 0.3s; }

@keyframes rowSlide {
    from {
        opacity: 0;
        transform: translateX(-20px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

/* Accessibility improvements */
.action-btn:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.4);
}

/* Print styles */
@media print {
    body {
        background: white;
        padding: 0;
    }
    
    .container {
        box-shadow: none;
        background: white;
        padding: 20px;
    }
    
    .navigation-links,
    .action-btn {
        display: none;
    }
    
    table {
        border: 1px solid #000;
    }
    
    th, td {
        border: 1px solid #000;
        padding: 8px;
    }
}
</style>
</head>
<body>
<div class="container">
<h2>All Patients</h2>
<%
List<Patient> patients = (List<Patient>) request.getAttribute("patients");
if (patients == null || patients.isEmpty()) {
%>
<div class="no-patients">
<p>No patients found</p>
</div>
<%
} else {
%>
<div class="table-container">
<div class="table-wrapper">
<table>
<tr>
<th>ID</th><th>Name</th><th>Age</th><th>Gender</th><th>Admission Date</th><th>Ailment</th><th>Assigned Doctor</th><th>Actions</th>
</tr>
<%
for (Patient p : patients) {
%>
<tr>
<td><%= p.getPatientID() %></td>
<td><%= p.getPatientName() %></td>
<td><%= p.getAge() %></td>
<td><%= p.getGender() %></td>
<td><%= p.getAdmissionDate() %></td>
<td><%= p.getAilment() %></td>
<td><%= p.getAssignedDoctor() %></td>
<td>
<a href="editPatient?id=<%= p.getPatientID() %>" class="action-btn edit-btn">Edit</a>
<a href="deletePatient?id=<%= p.getPatientID() %>" class="action-btn delete-btn" onclick="return confirm('Are you sure you want to delete this patient?');">Delete</a>
</td>
</tr>
<%
}
%>
</table>
</div>
</div>
<%
}
%>
<div class="navigation-links">
<a href="reportByDate.jsp" class="nav-link">📅 Patients by Date Range</a>
<a href="reportByAilment.jsp" class="nav-link">💉 Patients by Ailment</a>
<a href="reportByDoctor.jsp" class="nav-link">🩺 Patients by Assigned Doctor</a>
</div>
</div>
</body>
</html>
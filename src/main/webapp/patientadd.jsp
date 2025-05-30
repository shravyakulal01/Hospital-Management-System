<!-- patientadd.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Add New Patient</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        padding: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .hospital-container {
        max-width: 700px;
        width: 100%;
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        margin-bottom: 20px;
    }

    .header {
        background: linear-gradient(135deg, #2c5aa0 0%, #1e3c72 100%);
        color: white;
        padding: 30px;
        text-align: center;
        position: relative;
    }

    .header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="medical" patternUnits="userSpaceOnUse" width="20" height="20"><rect width="20" height="20" fill="none"/><path d="M10 5v10M5 10h10" stroke="rgba(255,255,255,0.1)" stroke-width="1"/></pattern></defs><rect width="100" height="100" fill="url(%23medical)"/></svg>') repeat;
        opacity: 0.3;
    }

    h2 {
        font-size: 2.2em;
        font-weight: 300;
        margin-bottom: 8px;
        position: relative;
        z-index: 1;
        color: white;
        text-align: center;
    }

    .subtitle {
        font-size: 1.1em;
        opacity: 0.9;
        position: relative;
        z-index: 1;
        color: white;
        text-align: center;
        margin-top: 10px;
    }

    .form-container {
        padding: 40px;
        background: #fafbfc;
    }

    form {
        display: flex;
        flex-direction: column;
        gap: 25px;
    }

    .form-row {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .form-label {
        color: #34495e;
        font-weight: 600;
        font-size: 0.95em;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    input[type="text"], 
    input[type="number"], 
    input[type="date"], 
    select {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid #e1e8ed;
        border-radius: 8px;
        font-size: 1em;
        font-family: inherit;
        transition: all 0.3s ease;
        background: #ffffff;
    }

    input[type="text"]:focus, 
    input[type="number"]:focus, 
    input[type="date"]:focus, 
    select:focus {
        outline: none;
        border-color: #2c5aa0;
        box-shadow: 0 0 0 3px rgba(44, 90, 160, 0.1);
        transform: translateY(-1px);
    }

    input[type="text"]:hover, 
    input[type="number"]:hover, 
    input[type="date"]:hover, 
    select:hover {
        border-color: #667eea;
    }

    select {
        background-image: url('data:image/svg+xml;charset=US-ASCII,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 4 5"><path fill="%23666" d="M2 0L0 2h4zm0 5L0 3h4z"/></svg>');
        background-repeat: no-repeat;
        background-position: right 12px center;
        background-size: 12px;
        appearance: none;
    }

    input[type="submit"] {
        background: linear-gradient(135deg, #2c5aa0 0%, #1e3c72 100%);
        color: white;
        padding: 16px 32px;
        border: none;
        border-radius: 8px;
        font-size: 1.1em;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-top: 20px;
        box-shadow: 0 4px 15px rgba(44, 90, 160, 0.3);
        position: relative;
        overflow: hidden;
    }

    input[type="submit"]::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
        transition: left 0.5s;
    }

    input[type="submit"]:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(44, 90, 160, 0.4);
    }

    input[type="submit"]:hover::before {
        left: 100%;
    }

    input[type="submit"]:active {
        transform: scale(0.98);
    }

    .view-link {
        display: inline-block;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 14px 28px;
        text-decoration: none;
        border-radius: 8px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        position: relative;
        overflow: hidden;
    }

    .view-link::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
        transition: left 0.5s;
    }

    .view-link:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        text-decoration: none;
        color: white;
    }

    .view-link:hover::before {
        left: 100%;
    }

    .link-container {
        text-align: center;
        margin-top: 20px;
    }

    /* Animation for form elements */
    .form-row {
        animation: fadeInUp 0.6s ease forwards;
        opacity: 0;
    }

    .form-row:nth-child(1) { animation-delay: 0.1s; }
    .form-row:nth-child(2) { animation-delay: 0.2s; }
    .form-row:nth-child(3) { animation-delay: 0.3s; }
    .form-row:nth-child(4) { animation-delay: 0.4s; }
    .form-row:nth-child(5) { animation-delay: 0.5s; }
    .form-row:nth-child(6) { animation-delay: 0.6s; }
    .form-row:nth-child(7) { animation-delay: 0.7s; }

    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    @media (max-width: 768px) {
        .hospital-container {
            margin: 10px;
        }
        
        .form-container {
            padding: 30px 20px;
        }
        
        h2 {
            font-size: 1.8em;
        }
    }
</style>
</head>
<body>
<div class="hospital-container">
    <div class="header">
        <h2>⚕️ Add New Patient</h2>
        <p class="subtitle">Patient Registration & Care Management</p>
    </div>
    
    <div class="form-container">
        <form action="addPatient" method="post">
            <div class="form-row">
                <label class="form-label">Patient Name:</label>
                <input type="text" name="patientName" required>
            </div>
            
            <div class="form-row">
                <label class="form-label">Age:</label>
                <input type="number" name="age" required>
            </div>
            
            <div class="form-row">
                <label class="form-label">Gender:</label>
                <select name="gender" required>
                    <option value="">Select</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                </select>
            </div>
            
            <div class="form-row">
                <label class="form-label">Admission Date:</label>
                <input type="date" name="admissionDate" required>
            </div>
            
            <div class="form-row">
                <label class="form-label">Ailment:</label>
                <input type="text" name="ailment" required>
            </div>
            
            <div class="form-row">
                <label class="form-label">Assigned Doctor:</label>
                <input type="text" name="assignedDoctor" required>
            </div>
            
            <input type="submit" value="Add Patient">
        </form>
    </div>
</div>

<div class="link-container">
    <a href="displayPatients" class="view-link">👥 View All Patients</a>
</div>
</body>
</html>
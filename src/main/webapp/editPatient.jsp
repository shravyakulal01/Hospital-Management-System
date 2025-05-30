<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.model.Patient" %>
<%
Patient patient = (Patient) request.getAttribute("patient");
if (patient == null) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Patient - Error</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .error-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 60px 40px;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .error-icon {
            font-size: 4rem;
            color: #e74c3c;
            margin-bottom: 20px;
        }

        .error-message {
            color: #2c3e50;
            font-size: 1.5rem;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">⚠️</div>
        <p class="error-message">Patient not found.</p>
    </div>
</body>
</html>
<%
} else {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Patient</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #667eea 100%);
            min-height: 100vh;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 25% 25%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 75% 75%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                linear-gradient(45deg, transparent 30%, rgba(255, 255, 255, 0.05) 50%, transparent 70%);
            animation: backgroundShift 15s ease-in-out infinite alternate;
        }

        @keyframes backgroundShift {
            0% { transform: translateX(-5px) translateY(-5px); }
            100% { transform: translateX(5px) translateY(5px); }
        }

        .main-container {
            max-width: 900px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(25px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 
                0 25px 50px rgba(0, 0, 0, 0.1),
                inset 0 1px 0 rgba(255, 255, 255, 0.2);
            position: relative;
            z-index: 1;
            animation: slideInUp 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(60px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .header-section {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            padding: 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .header-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: repeating-linear-gradient(
                45deg,
                transparent,
                transparent 15px,
                rgba(255, 255, 255, 0.1) 15px,
                rgba(255, 255, 255, 0.1) 30px
            );
            animation: shimmer 12s linear infinite;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%) translateY(-100%); }
            100% { transform: translateX(100%) translateY(100%); }
        }

        .main-title {
            color: white;
            font-size: 2.8rem;
            font-weight: 600;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 1;
            letter-spacing: -0.5px;
        }

        .patient-id-badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            margin-top: 15px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .form-container {
            padding: 50px;
        }

        .patient-form {
            display: grid;
            gap: 30px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
        }

        .form-group {
            position: relative;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-label {
            display: block;
            color: rgba(255, 255, 255, 0.9);
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
        }

        .form-input {
            width: 100%;
            padding: 18px 20px;
            border: 2px solid rgba(255, 255, 255, 0.25);
            border-radius: 14px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            color: white;
            font-size: 1rem;
            font-weight: 500;
            outline: none;
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }

        .form-input::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        .form-input:focus {
            border-color: rgba(79, 172, 254, 0.8);
            background: rgba(255, 255, 255, 0.18);
            box-shadow: 
                0 0 0 4px rgba(79, 172, 254, 0.25),
                0 10px 40px rgba(79, 172, 254, 0.2);
            transform: translateY(-2px);
        }

        .form-input:hover {
            border-color: rgba(255, 255, 255, 0.4);
            background: rgba(255, 255, 255, 0.15);
        }

        .form-select {
            width: 100%;
            padding: 18px 20px;
            border: 2px solid rgba(255, 255, 255, 0.25);
            border-radius: 14px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            color: white;
            font-size: 1rem;
            font-weight: 500;
            outline: none;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='white' viewBox='0 0 16 16'%3e%3cpath d='m7.247 4.86-4.796 5.481c-.566.647-.106 1.659.753 1.659h9.592a1 1 0 0 0 .753-1.659l-4.796-5.48a1 1 0 0 0-1.506 0z'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 20px center;
            background-size: 16px;
        }

        .form-select:focus {
            border-color: rgba(79, 172, 254, 0.8);
            background-color: rgba(255, 255, 255, 0.18);
            box-shadow: 
                0 0 0 4px rgba(79, 172, 254, 0.25),
                0 10px 40px rgba(79, 172, 254, 0.2);
            transform: translateY(-2px);
        }

        .form-select:hover {
            border-color: rgba(255, 255, 255, 0.4);
            background-color: rgba(255, 255, 255, 0.15);
        }

        .form-select option {
            background: #2c3e50;
            color: white;
            padding: 10px;
        }

        .submit-section {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .submit-button {
            padding: 18px 50px;
            border: none;
            border-radius: 50px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            font-size: 1.1rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            box-shadow: 0 10px 30px rgba(79, 172, 254, 0.4);
            min-width: 200px;
        }

        .submit-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transition: left 0.6s ease;
        }

        .submit-button:hover::before {
            left: 100%;
        }

        .submit-button:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 20px 50px rgba(79, 172, 254, 0.6);
            background: linear-gradient(135deg, #5bb5ff 0%, #1af3fe 100%);
        }

        .submit-button:active {
            transform: translateY(-1px) scale(0.98);
        }

        .cancel-button {
            padding: 18px 40px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 50px;
            background: transparent;
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            cursor: pointer;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .cancel-button:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-2px);
        }

        .floating-decorations {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            overflow: hidden;
            border-radius: 24px;
        }

        .floating-icon {
            position: absolute;
            color: rgba(255, 255, 255, 0.1);
            font-size: 2.5rem;
            animation: floatAround 10s ease-in-out infinite;
        }

        .floating-icon:nth-child(1) {
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-icon:nth-child(2) {
            top: 60%;
            right: 15%;
            animation-delay: 3s;
        }

        .floating-icon:nth-child(3) {
            bottom: 25%;
            left: 20%;
            animation-delay: 6s;
        }

        @keyframes floatAround {
            0%, 100% {
                transform: translateY(0px) translateX(0px) rotate(0deg);
                opacity: 0.3;
            }
            25% {
                transform: translateY(-15px) translateX(10px) rotate(5deg);
                opacity: 0.6;
            }
            50% {
                transform: translateY(-25px) translateX(-5px) rotate(-3deg);
                opacity: 0.8;
            }
            75% {
                transform: translateY(-10px) translateX(-10px) rotate(2deg);
                opacity: 0.4;
            }
        }

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }

            .main-container {
                border-radius: 20px;
            }

            .header-section {
                padding: 30px 25px;
            }

            .main-title {
                font-size: 2.2rem;
            }

            .form-container {
                padding: 30px 25px;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .submit-section {
                flex-direction: column;
                align-items: center;
            }

            .submit-button,
            .cancel-button {
                width: 100%;
                max-width: 300px;
            }
        }

        @media (max-width: 480px) {
            .main-title {
                font-size: 1.9rem;
            }

            .form-container {
                padding: 25px 20px;
            }

            .form-input,
            .form-select {
                padding: 16px 18px;
            }

            .submit-button,
            .cancel-button {
                padding: 16px 30px;
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="floating-decorations">
            <div class="floating-icon">✏️</div>
            <div class="floating-icon">👤</div>
            <div class="floating-icon">🏥</div>
        </div>

        <div class="header-section">
            <h2 class="main-title">Edit Patient</h2>
            <div class="patient-id-badge">
                Patient ID: <%= patient.getPatientID() %>
            </div>
        </div>

        <div class="form-container">
            <form action="updatePatient" method="post" class="patient-form">
                <input type="hidden" name="patientID" value="<%= patient.getPatientID() %>"/>
                
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">Name:</label>
                        <input type="text" name="patientName" class="form-input" value="<%= patient.getPatientName() %>" required/>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Age:</label>
                        <input type="number" name="age" class="form-input" value="<%= patient.getAge() %>" required/>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Gender:</label>
                        <select name="gender" class="form-select" required>
                            <option value="Male" <%= "Male".equals(patient.getGender()) ? "selected" : "" %>>Male</option>
                            <option value="Female" <%= "Female".equals(patient.getGender()) ? "selected" : "" %>>Female</option>
                            <option value="Other" <%= "Other".equals(patient.getGender()) ? "selected" : "" %>>Other</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Admission Date:</label>
                        <input type="date" name="admissionDate" class="form-input" value="<%= patient.getAdmissionDate() %>" required/>
                    </div>
                    
                    <div class="form-group full-width">
                        <label class="form-label">Ailment:</label>
                        <input type="text" name="ailment" class="form-input" value="<%= patient.getAilment() %>" required/>
                    </div>
                    
                    <div class="form-group full-width">
                        <label class="form-label">Assigned Doctor:</label>
                        <input type="text" name="assignedDoctor" class="form-input" value="<%= patient.getAssignedDoctor() %>" required/>
                    </div>
                </div>

                <div class="submit-section">
                    <input type="submit" value="Update Patient" class="submit-button"/>
                    <button type="button" class="cancel-button" onclick="history.back()">Cancel</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
<%
}
%>
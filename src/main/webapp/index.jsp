

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hospital Management System</title>
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
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    position: relative;
    overflow-x: hidden;
}

body::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: 
        radial-gradient(circle at 20% 50%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
        radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
        radial-gradient(circle at 40% 80%, rgba(120, 119, 198, 0.2) 0%, transparent 50%);
    pointer-events: none;
}

.container {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    border-radius: 24px;
    padding: 50px 40px;
    box-shadow: 
        0 25px 45px rgba(0, 0, 0, 0.15),
        0 0 0 1px rgba(255, 255, 255, 0.2);
    max-width: 600px;
    width: 100%;
    position: relative;
    z-index: 1;
    border: 1px solid rgba(255, 255, 255, 0.2);
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

h1 {
    color: #2c3e50;
    text-align: center;
    margin-bottom: 40px;
    font-size: 2.5rem;
    font-weight: 700;
    letter-spacing: -0.5px;
    position: relative;
    background: linear-gradient(135deg, #2c3e50, #3498db);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

h1::after {
    content: '';
    position: absolute;
    bottom: -15px;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 4px;
    background: linear-gradient(90deg, #3498db, #2c3e50);
    border-radius: 2px;
}

.links {
    margin-top: 30px;
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.links a {
    display: flex;
    align-items: center;
    padding: 20px 24px;
    font-size: 18px;
    text-decoration: none;
    color: #2c3e50;
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    border-radius: 16px;
    border: 2px solid transparent;
    transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    position: relative;
    overflow: hidden;
    font-weight: 600;
    letter-spacing: 0.3px;
}

.links a::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
    transition: left 0.5s;
}

.links a:hover::before {
    left: 100%;
}

.links a:hover {
    transform: translateY(-3px);
    box-shadow: 
        0 15px 35px rgba(52, 152, 219, 0.3),
        0 5px 15px rgba(0, 0, 0, 0.1);
    background: linear-gradient(135deg, #3498db, #2980b9);
    color: white;
    border-color: rgba(255, 255, 255, 0.3);
}

.links a:active {
    transform: translateY(-1px);
    transition: transform 0.1s;
}

.links a span {
    margin-right: 12px;
    font-size: 20px;
    filter: drop-shadow(0 1px 2px rgba(0, 0, 0, 0.1));
}

/* Enhanced emoji styling */
.links a:nth-child(1) span { color: #27ae60; }
.links a:nth-child(2) span { color: #f39c12; }
.links a:nth-child(3) span { color: #e74c3c; }
.links a:nth-child(4) span { color: #9b59b6; }
.links a:nth-child(5) span { color: #3498db; }

/* Responsive design */
@media (max-width: 768px) {
    body {
        padding: 15px;
    }
    
    .container {
        padding: 30px 25px;
        border-radius: 20px;
    }
    
    h1 {
        font-size: 2rem;
        margin-bottom: 30px;
    }
    
    .links a {
        padding: 16px 20px;
        font-size: 16px;
    }
    
    .links a span {
        font-size: 18px;
    }
}

@media (max-width: 480px) {
    .container {
        padding: 25px 20px;
        border-radius: 16px;
    }
    
    h1 {
        font-size: 1.8rem;
    }
    
    .links a {
        padding: 14px 18px;
        font-size: 15px;
    }
}

/* Loading animation for better UX */
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

/* Subtle pulse animation for the title */
h1 {
    animation: titlePulse 3s ease-in-out infinite;
}

@keyframes titlePulse {
    0%, 100% {
        text-shadow: 0 0 0 rgba(52, 152, 219, 0);
    }
    50% {
        text-shadow: 0 0 20px rgba(52, 152, 219, 0.3);
    }
}

/* Professional focus states for accessibility */
.links a:focus {
    outline: none;
    box-shadow: 
        0 0 0 3px rgba(52, 152, 219, 0.4),
        0 15px 35px rgba(52, 152, 219, 0.3);
    transform: translateY(-3px);
    background: linear-gradient(135deg, #3498db, #2980b9);
    color: white;
}

/* Additional visual enhancements */
.links a:nth-child(even) {
    background: linear-gradient(135deg, #ecf0f1, #d5dbdb);
}

.links a:nth-child(odd):hover,
.links a:nth-child(even):hover {
    background: linear-gradient(135deg, #3498db, #2980b9);
}
</style>
</head>
<body>
<div class="container">
<h1>Welcome to Hospital Management System</h1>
<div class="links">
<a href="patientadd.jsp"><span>➕</span> Register New Patient</a>
<a href="displayPatients"><span>📋</span> View All Patients</a>
<a href="reportByDate.jsp"><span>📅</span> Report: Patients Admitted in Date Range</a>
<a href="reportByAilment.jsp"><span>💉</span> Report: Patients by Ailment</a>
<a href="reportByDoctor.jsp"><span>🩺</span> Report: Patients by Assigned Doctor</a>
</div>
</div>
</body>
</html>
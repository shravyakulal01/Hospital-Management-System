<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>Patients by Doctor</title>
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
    max-width: 500px;
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

h2 {
    color: #2c3e50;
    text-align: center;
    margin-bottom: 40px;
    font-size: 2.2rem;
    font-weight: 700;
    letter-spacing: -0.5px;
    position: relative;
    background: linear-gradient(135deg, #2c3e50, #3498db);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    line-height: 1.2;
}

h2::after {
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

h2::before {
    content: '🩺';
    position: absolute;
    top: -50px;
    left: 50%;
    transform: translateX(-50%);
    font-size: 3rem;
    filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.1));
    animation: bounce 2s ease-in-out infinite;
}

@keyframes bounce {
    0%, 20%, 50%, 80%, 100% {
        transform: translateX(-50%) translateY(0);
    }
    40% {
        transform: translateX(-50%) translateY(-10px);
    }
    60% {
        transform: translateX(-50%) translateY(-5px);
    }
}

form {
    display: flex;
    flex-direction: column;
    gap: 30px;
    margin-top: 20px;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

label {
    font-size: 1.1rem;
    font-weight: 600;
    color: #2c3e50;
    letter-spacing: 0.3px;
    display: flex;
    align-items: center;
    gap: 8px;
}

label::before {
    content: '👨‍⚕️';
    font-size: 1.2rem;
    filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
}

input[type="text"] {
    padding: 18px 20px;
    border: 2px solid #e1e8ed;
    border-radius: 12px;
    font-size: 1rem;
    font-weight: 500;
    color: #2c3e50;
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(10px);
    transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    outline: none;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    position: relative;
}

input[type="text"]:focus {
    border-color: #3498db;
    box-shadow: 
        0 0 0 3px rgba(52, 152, 219, 0.2),
        0 8px 25px rgba(52, 152, 219, 0.15);
    transform: translateY(-2px);
    background: rgba(255, 255, 255, 1);
}

input[type="text"]:hover {
    border-color: #74b9ff;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
}

input[type="text"]::placeholder {
    color: #95a5a6;
    font-style: italic;
}

.submit-container {
    display: flex;
    justify-content: center;
    margin-top: 10px;
}

input[type="submit"] {
    padding: 16px 40px;
    background: linear-gradient(135deg, #3498db, #2980b9);
    color: white;
    border: none;
    border-radius: 12px;
    font-size: 1.1rem;
    font-weight: 600;
    letter-spacing: 0.5px;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    box-shadow: 0 8px 25px rgba(52, 152, 219, 0.3);
    position: relative;
    overflow: hidden;
    text-transform: uppercase;
    min-width: 160px;
}

input[type="submit"]::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s;
}

input[type="submit"]:hover::before {
    left: 100%;
}

input[type="submit"]:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 35px rgba(52, 152, 219, 0.4);
    background: linear-gradient(135deg, #2980b9, #1f4e79);
}

input[type="submit"]:active {
    transform: translateY(-1px);
    transition: transform 0.1s;
}

input[type="submit"]:focus {
    outline: none;
    box-shadow: 
        0 0 0 3px rgba(52, 152, 219, 0.4),
        0 12px 35px rgba(52, 152, 219, 0.4);
}

/* Search icon animation */
.search-icon {
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #95a5a6;
    font-size: 1.2rem;
    pointer-events: none;
    transition: all 0.3s ease;
}

.input-wrapper {
    position: relative;
}

input[type="text"]:focus + .search-icon {
    color: #3498db;
    transform: translateY(-50%) scale(1.1);
}

/* Enhanced visual effects */
.container::before {
    content: '';
    position: absolute;
    top: -2px;
    left: -2px;
    right: -2px;
    bottom: -2px;
    background: linear-gradient(45deg, #3498db, #2980b9, #8e44ad, #3498db);
    border-radius: 26px;
    z-index: -1;
    opacity: 0;
    transition: opacity 0.3s ease;
    animation: gradientShift 4s ease-in-out infinite;
}

@keyframes gradientShift {
    0%, 100% {
        background: linear-gradient(45deg, #3498db, #2980b9, #8e44ad, #3498db);
    }
    50% {
        background: linear-gradient(45deg, #8e44ad, #3498db, #2980b9, #8e44ad);
    }
}

.container:hover::before {
    opacity: 0.1;
}

/* Responsive design */
@media (max-width: 768px) {
    body {
        padding: 15px;
    }
    
    .container {
        padding: 40px 30px;
        border-radius: 20px;
    }
    
    h2 {
        font-size: 1.9rem;
        margin-bottom: 35px;
    }
    
    h2::before {
        font-size: 2.5rem;
        top: -45px;
    }
    
    input[type="text"] {
        padding: 16px 18px;
        font-size: 0.95rem;
    }
    
    input[type="submit"] {
        padding: 14px 35px;
        font-size: 1rem;
    }
}

@media (max-width: 480px) {
    .container {
        padding: 30px 25px;
        border-radius: 16px;
    }
    
    h2 {
        font-size: 1.7rem;
        margin-bottom: 30px;
    }
    
    h2::before {
        font-size: 2.2rem;
        top: -40px;
    }
    
    input[type="text"] {
        padding: 15px 16px;
        font-size: 0.9rem;
    }
    
    input[type="submit"] {
        padding: 13px 30px;
        font-size: 0.95rem;
        min-width: 140px;
    }
    
    form {
        gap: 25px;
    }
}

/* Loading animation */
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

/* Form validation styles */
input[type="text"]:invalid {
    border-color: #e74c3c;
    box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.2);
}

input[type="text"]:valid {
    border-color: #27ae60;
}

/* Professional focus ring */
*:focus {
    outline: none;
}

/* Accessibility improvements */
@media (prefers-reduced-motion: reduce) {
    * {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
    }
}
</style>
</head>
<body>
<div class="container">
<h2>Find Patients Assigned to a Doctor</h2>
<form action="reportByDoctor" method="get">
<div class="form-group">
<label for="doctor">Doctor Name:</label>
<div class="input-wrapper">
<input type="text" name="doctor" id="doctor" placeholder="Enter doctor's full name..." required />
<span class="search-icon">🔍</span>
</div>
</div>
<div class="submit-container">
<input type="submit" value="Search" />
</div>
</form>
</div>
</body>
</html>
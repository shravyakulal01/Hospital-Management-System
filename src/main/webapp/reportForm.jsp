<!DOCTYPE html>
<html>
<head>
<title>Patient Reports</title>
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
        radial-gradient(circle at 25% 25%, rgba(102, 126, 234, 0.2) 0%, transparent 50%),
        radial-gradient(circle at 75% 75%, rgba(118, 75, 162, 0.2) 0%, transparent 50%),
        radial-gradient(circle at 50% 50%, rgba(255, 255, 255, 0.1) 0%, transparent 60%);
    pointer-events: none;
}

.container {
    max-width: 900px;
    margin: 0 auto;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    border-radius: 24px;
    padding: 50px 40px;
    box-shadow: 
        0 25px 45px rgba(0, 0, 0, 0.15),
        0 0 0 1px rgba(255, 255, 255, 0.2);
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
    margin-bottom: 50px;
    font-size: 2.8rem;
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
    bottom: -20px;
    left: 50%;
    transform: translateX(-50%);
    width: 120px;
    height: 4px;
    background: linear-gradient(90deg, #3498db, #2c3e50);
    border-radius: 2px;
}

h2::before {
    content: '📊';
    position: absolute;
    top: -60px;
    left: 50%;
    transform: translateX(-50%);
    font-size: 3.5rem;
    filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.1));
    animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
    0%, 100% {
        transform: translateX(-50%) scale(1);
    }
    50% {
        transform: translateX(-50%) scale(1.05);
    }
}

.forms-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
    margin-top: 20px;
}

form {
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
    border: 2px solid rgba(255, 255, 255, 0.3);
    transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    position: relative;
    overflow: hidden;
    animation: formSlide 0.6s ease-out backwards;
}

form:nth-child(1) { animation-delay: 0.1s; }
form:nth-child(2) { animation-delay: 0.2s; }
form:nth-child(3) { animation-delay: 0.3s; }

@keyframes formSlide {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

form::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s;
}

form:hover::before {
    left: 100%;
}

form:hover {
    transform: translateY(-5px);
    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
    background: linear-gradient(135deg, #ffffff, #f1f3f4);
    border-color: rgba(52, 152, 219, 0.3);
}

h3 {
    color: #2c3e50;
    font-size: 1.4rem;
    font-weight: 600;
    margin-bottom: 25px;
    display: flex;
    align-items: center;
    gap: 12px;
    letter-spacing: 0.3px;
    position: relative;
}

/* Icon styling for each form */
form:nth-child(1) h3::before {
    content: '📅';
    font-size: 1.5rem;
    filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
}

form:nth-child(2) h3::before {
    content: '💉';
    font-size: 1.5rem;
    filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
}

form:nth-child(3) h3::before {
    content: '🩺';
    font-size: 1.5rem;
    filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
}

.form-group {
    margin-bottom: 20px;
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.date-range {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
    align-items: end;
}

label {
    font-size: 0.95rem;
    font-weight: 600;
    color: #2c3e50;
    letter-spacing: 0.3px;
}

input[type="date"],
input[type="text"] {
    padding: 14px 16px;
    border: 2px solid #e1e8ed;
    border-radius: 10px;
    font-size: 1rem;
    font-weight: 500;
    color: #2c3e50;
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(10px);
    transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    outline: none;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

input[type="date"]:focus,
input[type="text"]:focus {
    border-color: #3498db;
    box-shadow: 
        0 0 0 3px rgba(52, 152, 219, 0.2),
        0 8px 25px rgba(52, 152, 219, 0.15);
    transform: translateY(-1px);
    background: rgba(255, 255, 255, 1);
}

input[type="date"]:hover,
input[type="text"]:hover {
    border-color: #74b9ff;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
}

input[type="text"]::placeholder {
    color: #95a5a6;
    font-style: italic;
}

button[type="submit"] {
    width: 100%;
    padding: 16px;
    background: linear-gradient(135deg, #3498db, #2980b9);
    color: white;
    border: none;
    border-radius: 12px;
    font-size: 1.1rem;
    font-weight: 600;
    letter-spacing: 0.8px;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    box-shadow: 0 8px 25px rgba(52, 152, 219, 0.3);
    position: relative;
    overflow: hidden;
    text-transform: uppercase;
    margin-top: 10px;
}

button[type="submit"]::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s;
}

button[type="submit"]:hover::before {
    left: 100%;
}

button[type="submit"]:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 35px rgba(52, 152, 219, 0.4);
    background: linear-gradient(135deg, #2980b9, #1f4e79);
}

button[type="submit"]:active {
    transform: translateY(0px);
    transition: transform 0.1s;
}

button[type="submit"]:focus {
    outline: none;
    box-shadow: 
        0 0 0 3px rgba(52, 152, 219, 0.4),
        0 12px 35px rgba(52, 152, 219, 0.4);
}

/* Unique button colors for each form */
form:nth-child(1) button[type="submit"] {
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    box-shadow: 0 8px 25px rgba(231, 76, 60, 0.3);
}

form:nth-child(1) button[type="submit"]:hover {
    background: linear-gradient(135deg, #c0392b, #a93226);
    box-shadow: 0 12px 35px rgba(231, 76, 60, 0.4);
}

form:nth-child(2) button[type="submit"] {
    background: linear-gradient(135deg, #9b59b6, #8e44ad);
    box-shadow: 0 8px 25px rgba(155, 89, 182, 0.3);
}

form:nth-child(2) button[type="submit"]:hover {
    background: linear-gradient(135deg, #8e44ad, #7d3c98);
    box-shadow: 0 12px 35px rgba(155, 89, 182, 0.4);
}

form:nth-child(3) button[type="submit"] {
    background: linear-gradient(135deg, #27ae60, #229954);
    box-shadow: 0 8px 25px rgba(39, 174, 96, 0.3);
}

form:nth-child(3) button[type="submit"]:hover {
    background: linear-gradient(135deg, #229954, #1e8449);
    box-shadow: 0 12px 35px rgba(39, 174, 96, 0.4);
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
    animation: gradientShift 6s ease-in-out infinite;
}

@keyframes gradientShift {
    0%, 100% {
        background: linear-gradient(45deg, #3498db, #2980b9, #8e44ad, #3498db);
    }
    33% {
        background: linear-gradient(45deg, #e74c3c, #3498db, #2980b9, #e74c3c);
    }
    66% {
        background: linear-gradient(45deg, #27ae60, #e74c3c, #3498db, #27ae60);
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
        padding: 40px 25px;
        border-radius: 20px;
    }
    
    h2 {
        font-size: 2.2rem;
        margin-bottom: 40px;
    }
    
    h2::before {
        font-size: 2.8rem;
        top: -50px;
    }
    
    .forms-grid {
        grid-template-columns: 1fr;
        gap: 25px;
    }
    
    form {
        padding: 25px 20px;
    }
    
    .date-range {
        grid-template-columns: 1fr;
        gap: 12px;
    }
}

@media (max-width: 480px) {
    .container {
        padding: 30px 20px;
        border-radius: 16px;
    }
    
    h2 {
        font-size: 2rem;
        margin-bottom: 35px;
    }
    
    h2::before {
        font-size: 2.5rem;
        top: -45px;
    }
    
    form {
        padding: 20px 15px;
        border-radius: 16px;
    }
    
    h3 {
        font-size: 1.2rem;
        margin-bottom: 20px;
    }
    
    input[type="date"],
    input[type="text"] {
        padding: 12px 14px;
        font-size: 0.95rem;
    }
    
    button[type="submit"] {
        padding: 14px;
        font-size: 1rem;
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
input:invalid {
    border-color: #e74c3c;
}

input:valid {
    border-color: #27ae60;
}

/* Accessibility improvements */
@media (prefers-reduced-motion: reduce) {
    * {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
    }
}

/* Custom scrollbar */
::-webkit-scrollbar {
    width: 8px;
}

::-webkit-scrollbar-track {
    background: rgba(0, 0, 0, 0.1);
    border-radius: 4px;
}

::-webkit-scrollbar-thumb {
    background: linear-gradient(135deg, #3498db, #2980b9);
    border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
    background: linear-gradient(135deg, #2980b9, #1f4e79);
}
</style>
</head>
<body>
<div class="container">
<h2>Generate Patient Reports</h2>

<div class="forms-grid">
<form action="reportByDate" method="post">
<h3>Report by Admission Date</h3>
<div class="date-range">
<div class="form-group">
<label for="fromDate">From:</label>
<input type="date" name="fromDate" id="fromDate" required>
</div>
<div class="form-group">
<label for="toDate">To:</label>
<input type="date" name="toDate" id="toDate" required>
</div>
</div>
<button type="submit">Generate</button>
</form>

<form action="reportByAilment" method="post">
<h3>Report by Ailment</h3>
<div class="form-group">
<label for="ailment">Ailment:</label>
<input type="text" name="ailment" id="ailment" placeholder="Enter ailment name..." required>
</div>
<button type="submit">Generate</button>
</form>

<form action="reportByDoctor" method="post">
<h3>Report by Assigned Doctor</h3>
<div class="form-group">
<label for="doctorName">Doctor Name:</label>
<input type="text" name="doctorName" id="doctorName" placeholder="Enter doctor's full name..." required>
</div>
<button type="submit">Generate</button>
</form>
</div>
</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patients by Date Range</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        body::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: 
                conic-gradient(from 0deg, transparent, rgba(255, 255, 255, 0.1), transparent),
                radial-gradient(circle at 30% 70%, rgba(103, 126, 234, 0.4) 0%, transparent 50%),
                radial-gradient(circle at 70% 30%, rgba(240, 147, 251, 0.4) 0%, transparent 50%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .main-container {
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(25px);
            border: 1px solid rgba(255, 255, 255, 0.18);
            border-radius: 28px;
            padding: 60px 50px;
            box-shadow: 
                0 30px 60px rgba(0, 0, 0, 0.12),
                inset 0 1px 0 rgba(255, 255, 255, 0.2);
            max-width: 700px;
            width: 100%;
            position: relative;
            z-index: 1;
            animation: slideIn 1s cubic-bezier(0.23, 1, 0.32, 1);
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(80px) scale(0.9);
                filter: blur(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
                filter: blur(0);
            }
        }

        .main-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
            border-radius: 28px;
            pointer-events: none;
        }

        .header {
            text-align: center;
            margin-bottom: 45px;
            position: relative;
            z-index: 2;
        }

        .main-title {
            color: white;
            font-size: 2.8rem;
            font-weight: 600;
            margin-bottom: 15px;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            letter-spacing: -1px;
            line-height: 1.2;
        }

        .subtitle {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1rem;
            font-weight: 400;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .title-decoration {
            position: absolute;
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, #4facfe, #00f2fe, #4facfe);
            border-radius: 2px;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% {
                opacity: 0.7;
                transform: translateX(-50%) scaleX(1);
            }
            50% {
                opacity: 1;
                transform: translateX(-50%) scaleX(1.2);
            }
        }

        .date-form {
            position: relative;
            z-index: 2;
        }

        .date-range-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 40px;
        }

        .date-field {
            position: relative;
        }

        .date-label {
            display: block;
            color: rgba(255, 255, 255, 0.95);
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 12px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
        }

        .date-input {
            width: 100%;
            padding: 18px 20px;
            border: 2px solid rgba(255, 255, 255, 0.25);
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            color: white;
            font-size: 1rem;
            font-weight: 500;
            outline: none;
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            position: relative;
        }

        .date-input::-webkit-calendar-picker-indicator {
            filter: invert(1);
            opacity: 0.8;
            cursor: pointer;
            transition: opacity 0.3s ease;
        }

        .date-input::-webkit-calendar-picker-indicator:hover {
            opacity: 1;
            transform: scale(1.1);
        }

        .date-input:focus {
            border-color: rgba(79, 172, 254, 0.8);
            background: rgba(255, 255, 255, 0.18);
            box-shadow: 
                0 0 0 4px rgba(79, 172, 254, 0.25),
                0 10px 40px rgba(79, 172, 254, 0.2);
            transform: translateY(-2px);
        }

        .date-input:hover {
            border-color: rgba(255, 255, 255, 0.4);
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-1px);
        }

        .date-field::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, rgba(79, 172, 254, 0.1), rgba(0, 242, 254, 0.1));
            border-radius: 16px;
            opacity: 0;
            transition: opacity 0.3s ease;
            pointer-events: none;
        }

        .date-field:hover::before {
            opacity: 1;
        }

        .date-separator {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 20px 0;
            position: relative;
        }

        .separator-line {
            flex: 1;
            height: 2px;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            border-radius: 1px;
        }

        .separator-icon {
            margin: 0 20px;
            color: rgba(255, 255, 255, 0.6);
            font-size: 1.5rem;
            animation: bounce 2s ease-in-out infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-5px);
            }
            60% {
                transform: translateY(-3px);
            }
        }

        .search-button {
            width: 100%;
            padding: 20px;
            border: none;
            border-radius: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-size: 1.2rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            box-shadow: 0 10px 30px rgba(118, 75, 162, 0.4);
        }

        .search-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.7s ease;
        }

        .search-button:hover::before {
            left: 100%;
        }

        .search-button:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 50px rgba(118, 75, 162, 0.6);
            background: linear-gradient(135deg, #7b8ff0 0%, #8a5cb8 100%);
        }

        .search-button:active {
            transform: translateY(-2px) scale(0.98);
            box-shadow: 0 8px 25px rgba(118, 75, 162, 0.4);
        }

        .search-icon {
            display: inline-block;
            margin-left: 10px;
            transition: transform 0.3s ease;
        }

        .search-button:hover .search-icon {
            transform: translateX(5px);
        }

        .floating-elements {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            overflow: hidden;
            border-radius: 28px;
        }

        .floating-date {
            position: absolute;
            color: rgba(255, 255, 255, 0.08);
            font-size: 3rem;
            font-weight: 700;
            animation: floatMove 8s ease-in-out infinite;
        }

        .floating-date:nth-child(1) {
            top: 15%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-date:nth-child(2) {
            top: 70%;
            right: 15%;
            animation-delay: 3s;
        }

        .floating-date:nth-child(3) {
            bottom: 20%;
            left: 25%;
            animation-delay: 6s;
        }

        @keyframes floatMove {
            0%, 100% {
                transform: translateY(0px) rotate(0deg);
                opacity: 0.4;
            }
            33% {
                transform: translateY(-20px) rotate(2deg);
                opacity: 0.8;
            }
            66% {
                transform: translateY(-10px) rotate(-1deg);
                opacity: 0.6;
            }
        }

        .background-grid {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: 
                linear-gradient(rgba(255, 255, 255, 0.02) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255, 255, 255, 0.02) 1px, transparent 1px);
            background-size: 50px 50px;
            pointer-events: none;
            z-index: 0;
            animation: gridMove 20s linear infinite;
        }

        @keyframes gridMove {
            0% { transform: translate(0, 0); }
            100% { transform: translate(50px, 50px); }
        }

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }

            .main-container {
                padding: 40px 30px;
                border-radius: 24px;
            }

            .main-title {
                font-size: 2.2rem;
                margin-bottom: 10px;
            }

            .subtitle {
                font-size: 1rem;
            }

            .date-range-container {
                grid-template-columns: 1fr;
                gap: 20px;
                margin-bottom: 30px;
            }

            .date-separator {
                transform: rotate(90deg);
                margin: 15px 0;
            }

            .search-button {
                font-size: 1.1rem;
                padding: 18px;
            }
        }

        @media (max-width: 480px) {
            .main-container {
                padding: 30px 20px;
            }

            .main-title {
                font-size: 1.9rem;
            }

            .date-input {
                padding: 16px 18px;
            }

            .search-button {
                font-size: 1rem;
                letter-spacing: 1.5px;
            }
        }

        .form-hint {
            text-align: center;
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
            margin-top: 20px;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="background-grid"></div>

    <div class="main-container">
        <div class="floating-elements">
            <div class="floating-date">📅</div>
            <div class="floating-date">📊</div>
            <div class="floating-date">🏥</div>
        </div>

        <div class="header">
            <h2 class="main-title">Find Patients Admitted Between Dates</h2>
            <p class="subtitle">Select date range to filter patient admissions</p>
            <div class="title-decoration"></div>
        </div>
        
        <form action="reportByDate" method="get" class="date-form">
            <div class="date-range-container">
                <div class="date-field">
                    <label class="date-label">From:</label>
                    <input type="date" name="fromDate" class="date-input" required />
                </div>
                
                <div class="date-field">
                    <label class="date-label">To:</label>
                    <input type="date" name="toDate" class="date-input" required />
                </div>
            </div>

            <div class="date-separator">
                <div class="separator-line"></div>
                <div class="separator-icon">⏰</div>
                <div class="separator-line"></div>
            </div>
            
            <button type="submit" class="search-button">
                Search Patients
                <span class="search-icon">🔍</span>
            </button>

            <div class="form-hint">
                Select both start and end dates to view patient admission records
            </div>
        </form>
    </div>
</body>
</html>
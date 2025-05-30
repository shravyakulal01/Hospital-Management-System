<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patients by Ailment</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, 'Roboto', 'Oxygen', 'Ubuntu', sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 50%, #667eea 100%);
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
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 50%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 40% 80%, rgba(120, 219, 255, 0.3) 0%, transparent 50%);
            animation: backgroundShift 10s ease-in-out infinite alternate;
        }

        @keyframes backgroundShift {
            0% {
                filter: hue-rotate(0deg);
            }
            100% {
                filter: hue-rotate(30deg);
            }
        }

        .container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 24px;
            padding: 50px;
            box-shadow: 
                0 25px 50px rgba(0, 0, 0, 0.1),
                0 0 0 1px rgba(255, 255, 255, 0.05);
            max-width: 600px;
            width: 100%;
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

        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
            border-radius: 24px;
            pointer-events: none;
        }

        h2 {
            color: white;
            font-size: 2.5rem;
            font-weight: 300;
            text-align: center;
            margin-bottom: 40px;
            text-shadow: 0 2px 20px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 2;
            letter-spacing: -0.5px;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, #4facfe, #00f2fe);
            border-radius: 2px;
            animation: glow 2s ease-in-out infinite alternate;
        }

        @keyframes glow {
            from {
                box-shadow: 0 0 5px rgba(79, 172, 254, 0.5);
            }
            to {
                box-shadow: 0 0 20px rgba(79, 172, 254, 0.8);
            }
        }

        .search-form {
            display: flex;
            flex-direction: column;
            gap: 30px;
            position: relative;
            z-index: 2;
        }

        .input-group {
            position: relative;
        }

        .input-label {
            display: block;
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.1rem;
            font-weight: 500;
            margin-bottom: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
        }

        .search-input {
            width: 100%;
            padding: 20px 25px;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            color: white;
            font-size: 1.1rem;
            font-weight: 400;
            outline: none;
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            position: relative;
        }

        .search-input::placeholder {
            color: rgba(255, 255, 255, 0.6);
            font-style: italic;
        }

        .search-input:focus {
            border-color: rgba(79, 172, 254, 0.8);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 
                0 0 0 4px rgba(79, 172, 254, 0.2),
                0 8px 32px rgba(79, 172, 254, 0.3);
            transform: translateY(-2px);
        }

        .search-input:hover {
            border-color: rgba(255, 255, 255, 0.4);
            background: rgba(255, 255, 255, 0.15);
        }

        .input-group::after {
            content: '🔍';
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-25%);
            font-size: 1.2rem;
            opacity: 0.6;
            pointer-events: none;
            transition: all 0.3s ease;
        }

        .search-input:focus + .input-group::after,
        .input-group:hover::after {
            opacity: 1;
            transform: translateY(-25%) scale(1.1);
        }

        .search-button {
            padding: 18px 40px;
            border: none;
            border-radius: 50px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            box-shadow: 0 8px 30px rgba(79, 172, 254, 0.4);
            align-self: center;
            min-width: 200px;
        }

        .search-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.6s ease;
        }

        .search-button:hover::before {
            left: 100%;
        }

        .search-button:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 15px 40px rgba(79, 172, 254, 0.6);
            background: linear-gradient(135deg, #5bb5ff 0%, #1af3fe 100%);
        }

        .search-button:active {
            transform: translateY(-1px) scale(0.98);
            box-shadow: 0 5px 20px rgba(79, 172, 254, 0.4);
        }

        .decorative-elements {
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
            font-size: 2rem;
            animation: float 6s ease-in-out infinite;
        }

        .floating-icon:nth-child(1) {
            top: 20%;
            left: 15%;
            animation-delay: 0s;
        }

        .floating-icon:nth-child(2) {
            top: 60%;
            right: 15%;
            animation-delay: 2s;
        }

        .floating-icon:nth-child(3) {
            bottom: 20%;
            left: 20%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px) rotate(0deg);
                opacity: 0.3;
            }
            50% {
                transform: translateY(-15px) rotate(5deg);
                opacity: 0.1;
            }
        }

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }

            .container {
                padding: 30px 25px;
                border-radius: 20px;
            }

            h2 {
                font-size: 2rem;
                margin-bottom: 30px;
            }

            .search-form {
                gap: 25px;
            }

            .search-input {
                padding: 16px 20px;
                font-size: 1rem;
            }

            .search-button {
                padding: 16px 35px;
                font-size: 1rem;
                min-width: 180px;
            }

            .input-group::after {
                right: 15px;
                font-size: 1.1rem;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 25px 20px;
            }

            h2 {
                font-size: 1.8rem;
            }

            .search-button {
                width: 100%;
                min-width: unset;
            }
        }

        .particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 0;
        }

        .particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            animation: particleFloat 15s infinite linear;
        }

        .particle:nth-child(1) { left: 10%; animation-delay: 0s; }
        .particle:nth-child(2) { left: 20%; animation-delay: 2s; }
        .particle:nth-child(3) { left: 30%; animation-delay: 4s; }
        .particle:nth-child(4) { left: 40%; animation-delay: 6s; }
        .particle:nth-child(5) { left: 50%; animation-delay: 8s; }
        .particle:nth-child(6) { left: 60%; animation-delay: 10s; }
        .particle:nth-child(7) { left: 70%; animation-delay: 12s; }
        .particle:nth-child(8) { left: 80%; animation-delay: 14s; }
        .particle:nth-child(9) { left: 90%; animation-delay: 16s; }

        @keyframes particleFloat {
            0% {
                transform: translateY(100vh) scale(0);
                opacity: 0;
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                transform: translateY(-100px) scale(1);
                opacity: 0;
            }
        }
    </style>
</head>
<body>
    <div class="particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>

    <div class="container">
        <div class="decorative-elements">
            <div class="floating-icon">⚕️</div>
            <div class="floating-icon">🏥</div>
            <div class="floating-icon">📋</div>
        </div>

        <h2>Find Patients by Ailment</h2>
        
        <form action="reportByAilment" method="get" class="search-form">
            <div class="input-group">
                <label class="input-label">Ailment:</label>
                <input type="text" name="ailment" class="search-input" placeholder="Enter ailment to search..." required />
            </div>
            <input type="submit" value="Search" class="search-button" />
        </form>
    </div>
</body>
</html>
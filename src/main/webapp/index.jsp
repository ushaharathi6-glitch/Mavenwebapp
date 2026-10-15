```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Simple Calculator</title>

    <style>
        /* Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Page background */
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #141e30, #243b55);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        /* Calculator card */
        .calculator {
            background: #ffffff;
            width: 100%;
            max-width: 440px;
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
        }

        /* Heading */
        h1 {
            text-align: center;
            color: #243b55;
            font-size: 30px;
            margin-bottom: 8px;
        }

        .subtitle {
            text-align: center;
            color: #718096;
            font-size: 14px;
            margin-bottom: 30px;
        }

        /* Input groups */
        .input-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            color: #2d3748;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        input[type="number"] {
            width: 100%;
            padding: 13px 15px;
            border: 1px solid #d9e2ec;
            border-radius: 10px;
            font-size: 16px;
            outline: none;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input[type="number"]:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
        }

        /* Operation buttons */
        .button-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-top: 25px;
        }

        button {
            padding: 13px 10px;
            border: none;
            border-radius: 10px;
            color: white;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, opacity 0.2s;
        }

        button:hover {
            transform: translateY(-2px);
            opacity: 0.9;
        }

        .add {
            background: #2563eb;
        }

        .subtract {
            background: #7c3aed;
        }

        .multiply {
            background: #0891b2;
        }

        .divide {
            background: #ea580c;
        }

        /* Result display */
        .result {
            margin-top: 25px;
            padding: 18px;
            border-radius: 12px;
            background: #ecfdf5;
            border: 1px solid #a7f3d0;
            text-align: center;
            overflow-wrap: anywhere;
        }

        .result-label {
            color: #047857;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 8px;
        }

        .result-value {
            color: #065f46;
            font-size: 28px;
            font-weight: 700;
        }

        /* Error message */
        .error {
            margin-top: 20px;
            padding: 14px;
            background: #fef2f2;
            color: #b91c1c;
            border: 1px solid #fecaca;
            border-radius: 10px;
            text-align: center;
            font-weight: 600;
        }

        /* Footer */
        .footer {
            text-align: center;
            margin-top: 25px;
            color: #94a3b8;
            font-size: 12px;
        }

        /* Mobile responsiveness */
        @media (max-width: 480px) {
            .calculator {
                padding: 25px 20px;
            }

            h1 {
                font-size: 26px;
            }

            .result-value {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>

    <div class="calculator">

        <h1>Simple Calculator</h1>
        <p class="subtitle">Perform basic mathematical operations</p>

        <form method="post" action="calculator.jsp">

            <div class="input-group">
                <label for="num1">Number 1</label>
                <input
                    type="number"
                    id="num1"
                    name="num1"
                    step="any"
                    placeholder="Enter first number"
                    value="<%= request.getParameter("num1") != null
                        ? request.getParameter("num1") : "" %>"
                    required>
            </div>

            <div class="input-group">
                <label for="num2">Number 2</label>
                <input
                    type="number"
                    id="num2"
                    name="num2"
                    step="any"
                    placeholder="Enter second number"
                    value="<%= request.getParameter("num2") != null
                        ? request.getParameter("num2") : "" %>"
                    required>
            </div>

            <div class="button-grid">
                <button type="submit" name="operation"
                        value="add" class="add">+ Add</button>

                <button type="submit" name="operation"
                        value="subtract" class="subtract">− Subtract</button>

                <button type="submit" name="operation"
                        value="multiply" class="multiply">× Multiply</button>

                <button type="submit" name="operation"
                        value="divide" class="divide">÷ Divide</button>
            </div>

        </form>

        <%
            String n1 = request.getParameter("num1");
            String n2 = request.getParameter("num2");
            String operation = request.getParameter("operation");

            if (n1 != null && !n1.trim().isEmpty()
                    && n2 != null && !n2.trim().isEmpty()
                    && operation != null) {

                try {
                    double num1 = Double.parseDouble(n1);
                    double num2 = Double.parseDouble(n2);
                    double result = 0;
                    boolean validOperation = true;
                    boolean divisionByZero = false;

                    switch (operation) {
                        case "add":
                            result = num1 + num2;
                            break;

                        case "subtract":
                            result = num1 - num2;
                            break;

                        case "multiply":
                            result = num1 * num2;
                            break;

                        case "divide":
                            if (num2 != 0) {
                                result = num1 / num2;
                            } else {
                                divisionByZero = true;
                            }
                            break;

                        default:
                            validOperation = false;
                    }

                    if (divisionByZero) {
        %>
                        <div class="error">
                            Cannot divide by zero. Please enter a non-zero
                            second number.
                        </div>
        <%
                    } else if (validOperation
                            && Double.isFinite(result)) {
        %>
                        <div class="result">
                            <div class="result-label">Calculation Result</div>
                            <div class="result-value">
                                <%= result %>
                            </div>
                        </div>
        <%
                    } else if (validOperation) {
        %>
                        <div class="error">
                            The result is too large or cannot be represented.
                        </div>
        <%
                    }

                } catch (NumberFormatException e) {
        %>
                    <div class="error">
                        Invalid number. Please enter valid numeric values.
                    </div>
        <%
                }
            }
        %>

        <div class="footer">
            Simple Calculator | Powered by JSP
        </div>

    </div>

</body>
</html>
```

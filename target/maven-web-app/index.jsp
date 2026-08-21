<!DOCTYPE html>
<html>
<head>
    <title>Simple Calculator</title>
</head>
<body>

    <h1>Simple Calculator</h1>

    <form>
        Number 1:
        <input type="number" name="num1" required>
        <br><br>

        Number 2:
        <input type="number" name="num2" required>
        <br><br>

        <button type="submit" name="operation" value="add">Add</button>
        <button type="submit" name="operation" value="subtract">Subtract</button>
        <button type="submit" name="operation" value="multiply">Multiply</button>
        <button type="submit" name="operation" value="divide">Divide</button>
    </form>

    <%
        String n1 = request.getParameter("num1");
        String n2 = request.getParameter("num2");
        String operation = request.getParameter("operation");

        if (n1 != null && n2 != null && operation != null) {

            double num1 = Double.parseDouble(n1);
            double num2 = Double.parseDouble(n2);
            double result = 0;

            if (operation.equals("add")) {
                result = num1 + num2;
            }
            else if (operation.equals("subtract")) {
                result = num1 - num2;
            }
            else if (operation.equals("multiply")) {
                result = num1 * num2;
            }
            else if (operation.equals("divide")) {
                if (num2 != 0) {
                    result = num1 / num2;
                } else {
                    out.println("<h3>Cannot divide by zero</h3>");
                    return;
                }
            }

            out.println("<h3>Result: " + result + "</h3>");
        }
    %>

</body>
</html>
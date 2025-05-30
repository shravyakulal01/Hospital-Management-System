<!-- patientupdate.jsp -->
<%@ page import="com.model.Patient" %>
<%
    Patient patient = (Patient) request.getAttribute("patient");
    if (patient == null) {
        out.println("No patient data found to update.");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Patient</title>
</head>
<body>
    <h2>Update Patient</h2>
    <form action="updatePatient" method="post">
        <!-- hidden PatientID -->
        <input type="hidden" name="patientID" value="<%= patient.getPatientID() %>">
        
        Patient Name: <input type="text" name="patientName" value="<%= patient.getPatientName() %>" required><br><br>
        Age: <input type="number" name="age" value="<%= patient.getAge() %>" required><br><br>
        Gender: 
        <select name="gender" required>
            <option value="Male" <%= "Male".equals(patient.getGender()) ? "selected" : "" %>>Male</option>
            <option value="Female" <%= "Female".equals(patient.getGender()) ? "selected" : "" %>>Female</option>
        </select><br><br>
        Admission Date: <input type="date" name="admissionDate" value="<%= patient.getAdmissionDate() %>" required><br><br>
        Ailment: <input type="text" name="ailment" value="<%= patient.getAilment() %>" required><br><br>
        Assigned Doctor: <input type="text" name="assignedDoctor" value="<%= patient.getAssignedDoctor() %>" required><br><br>
        
        <input type="submit" value="Update Patient">
    </form>
    <br>
    <a href="displayPatients">Back to Patient List</a>
</body>
</html>

package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/addPatient")
public class AddPatientServlet extends HttpServlet {
    private HospitalDAO hospitalDAO;

    public void init() {
        hospitalDAO = new HospitalDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String patientName = request.getParameter("patientName");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String admissionDate = request.getParameter("admissionDate");
        String ailment = request.getParameter("ailment");
        String assignedDoctor = request.getParameter("assignedDoctor");

        Patient patient = new Patient();
        patient.setPatientName(patientName);
        patient.setAge(age);
        patient.setGender(gender);
        patient.setAdmissionDate(admissionDate);
        patient.setAilment(ailment);
        patient.setAssignedDoctor(assignedDoctor);

        try {
            hospitalDAO.addPatient(patient);
            response.sendRedirect("displayPatients");  // redirect to patient list after adding
        } catch (SQLException e) {
            throw new ServletException("Error adding patient", e);
        }
    }
}

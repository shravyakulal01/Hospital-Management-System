package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/updatePatient")
public class UpdatePatientServlet extends HttpServlet {
    private HospitalDAO hospitalDAO;

    public void init() {
        hospitalDAO = new HospitalDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int patientID = Integer.parseInt(request.getParameter("patientID"));
            String name = request.getParameter("patientName");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String admissionDate = request.getParameter("admissionDate");
            String ailment = request.getParameter("ailment");
            String assignedDoctor = request.getParameter("assignedDoctor");

            Patient patient = new Patient(patientID, name, age, gender, admissionDate, ailment, assignedDoctor);
            hospitalDAO.updatePatient(patient);

            response.sendRedirect("displayPatients");  // redirect back to patient list page
        } catch (SQLException e) {
            throw new ServletException("Error updating patient", e);
        }
    }
}

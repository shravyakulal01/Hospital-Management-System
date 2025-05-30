package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/reportByDoctor")
public class ReportByDoctorServlet extends HttpServlet {
    private HospitalDAO hospitalDAO;

    public void init() {
        hospitalDAO = new HospitalDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String doctor = request.getParameter("doctor");

        try {
            List<Patient> patients = hospitalDAO.getPatientsByDoctor(doctor);
            request.setAttribute("patients", patients);
            request.getRequestDispatcher("patientdisplay.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving patients by doctor", e);
        }
    }
}

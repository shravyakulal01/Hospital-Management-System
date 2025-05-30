package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/reportByAilment")
public class ReportByAilmentServlet extends HttpServlet {
    private HospitalDAO hospitalDAO;

    public void init() {
        hospitalDAO = new HospitalDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ailment = request.getParameter("ailment");

        try {
            List<Patient> patients = hospitalDAO.getPatientsByAilment(ailment);
            request.setAttribute("patients", patients);
            request.getRequestDispatcher("patientdisplay.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving patients by ailment", e);
        }
    }
}